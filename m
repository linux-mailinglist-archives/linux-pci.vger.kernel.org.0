Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D305D20782A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 17:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404672AbgFXP5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 11:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404751AbgFXP5b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 11:57:31 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C73320738;
        Wed, 24 Jun 2020 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593014249;
        bh=TFbrStPgH0pBy/slvvWu+qkTCJDT70Ad6MI20rDtJ4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cQkjzUlh2jIdadwkRzkY5xIqCJDZJlFARv5DmHiB7zklJhVs6KqOYUj6GamxNNkon
         rq2tvZcX6AIGnkrOpLYYEHGqM6VoYWdCFTSuzjZ3H/f/zjf6ZexdttR1siv7IrZfrL
         PGDkUN3SeAipVIfy+/DZVZXGM5p0pgldrYNCt5i0=
Date:   Wed, 24 Jun 2020 10:57:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     mj@ucw.cz, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pciutils: Add decode support for RCECs
Message-ID: <20200624155727.GA2554730@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624040024.895996-1-sean.v.kelley@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 23, 2020 at 09:00:24PM -0700, Sean V Kelley wrote:
> Root Complex Event Collectors provide support for terminating error
> and PME messages from RCiEPs.  This patch provides basic decoding for
> the lspci RCEC Endpoint Association Extended Capability. See PCIe 5.0-1,
> sec 7.9.10 for further details.
> 
> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>

Looks good to me.  Minor comments below, but either way:

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> Changes since v1 [1]:
> 
> - Corrections to commit log wording/abbreviation.
> - Added mention of Endpoint Association for clarity.
> - Removed "Desc:" from output as not necessary.
> - Removed "cap_ver" from output as redundant.
> - Broke out RCiEP device numbers as a comma separated list.
> (Bjorn Helgaas)
> 
> [1] https://lore.kernel.org/linux-pci/20200622230330.799259-1-sean.v.kelley@linux.intel.com/
> 
> Thanks,
> 
> Sean
> ---
>  lib/header.h   |   8 +-
>  ls-ecaps.c     |  50 ++++++++-
>  setpci.c       |   2 +-
>  tests/cap-rcec | 299 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 355 insertions(+), 4 deletions(-)
>  create mode 100644 tests/cap-rcec
> 
> diff --git a/lib/header.h b/lib/header.h
> index 472816e..57a9343 100644
> --- a/lib/header.h
> +++ b/lib/header.h
> @@ -219,7 +219,7 @@
>  #define PCI_EXT_CAP_ID_PB	0x04	/* Power Budgeting */
>  #define PCI_EXT_CAP_ID_RCLINK	0x05	/* Root Complex Link Declaration */
>  #define PCI_EXT_CAP_ID_RCILINK	0x06	/* Root Complex Internal Link Declaration */
> -#define PCI_EXT_CAP_ID_RCECOLL	0x07	/* Root Complex Event Collector */
> +#define PCI_EXT_CAP_ID_RCEC	0x07	/* Root Complex Event Collector */
>  #define PCI_EXT_CAP_ID_MFVC	0x08	/* Multi-Function Virtual Channel */
>  #define PCI_EXT_CAP_ID_VC2	0x09	/* Virtual Channel (2nd ID) */
>  #define PCI_EXT_CAP_ID_RCRB	0x0a	/* Root Complex Register Block */
> @@ -1048,6 +1048,12 @@
>  #define  PCI_RCLINK_LINK_ADDR	8	/* Link Entry: Address (64-bit) */
>  #define  PCI_RCLINK_LINK_SIZE	16	/* Link Entry: sizeof */
> 
> +/* Root Complex Event Collector Endpoint Association */
> +#define  PCI_RCEC_EP_CAP_VER(reg)	(((reg) >> 16) & 0xf)
> +#define  PCI_RCEC_BUSN_REG_VER	0x02	/* as per PCIe sec 7.9.10.1 */
> +#define  PCI_RCEC_RCIEP_BMAP	0x0004	/* as per PCIe sec 7.9.10.2 */
> +#define  PCI_RCEC_BUSN_REG	0x0008	/* as per PCIe sec 7.9.10.3 */
> +
>  /* PCIe Vendor-Specific Capability */
>  #define PCI_EVNDR_HEADER	4	/* Vendor-Specific Header */
>  #define PCI_EVNDR_REGISTERS	8	/* Vendor-Specific Registers */
> diff --git a/ls-ecaps.c b/ls-ecaps.c
> index e71209e..ae26393 100644
> --- a/ls-ecaps.c
> +++ b/ls-ecaps.c
> @@ -634,6 +634,52 @@ cap_rclink(struct device *d, int where)
>      }
>  }
> 
> +static void
> +cap_rcec(struct device *d, int where)
> +{
> +  printf("Root Complex Event Collector Endpoint Association\n");
> +  if (verbose < 2)
> +    return;
> +
> +  if (!config_fetch(d, where, 12))
> +    return;
> +
> +  u32 hdr = get_conf_long(d, where);
> +  byte cap_ver = PCI_RCEC_EP_CAP_VER(hdr);
> +  u32 bmap = get_conf_long(d, where + PCI_RCEC_RCIEP_BMAP);
> +  printf("\t\tRCiEPBitmap: ");
> +  if (bmap)
> +    {
> +      int dev=0;
> +      int prevmatched=0;
> +      printf("RCiEP at Device(s):");
> +      while (bmap)
> +        {
> +	  if (BITS(bmap, 0, 1))
> +	      if (!prevmatched)
> +	        {
> +		  prevmatched=1;
> +		  printf(" %u", dev);
> +	        }
> +	      else
> +	          printf("%s %u", (prevmatched) ? "," : "", dev);

Maybe this could be done in one printf?

  if (bmap)
    {
      int prevmatched = 0;

      for (dev = 0; dev < 32; dev++)
	if (BITS(bmap, dev, 1))
	  {
	    printf("%s%u", prevmatched ? ", " : "", dev);
	    prevmatched = 1;
	  }
    }

> +	  bmap >>= 1;
> +	  dev += 1;
> +        }
> +    }
> +  else
> +    printf("00000000");

Or "[none]", with "00000000 [none]" for the "-vvv" case?  Seems like an
RCEC with no associated devices wouldn't be very useful.  Although I
guess it could have devices on other buses.

> +  printf("\n");
> +
> +  if (cap_ver < PCI_RCEC_BUSN_REG_VER)
> +    return;
> +
> +  u32 busn = get_conf_long(d, where + PCI_RCEC_BUSN_REG);
> +  printf("\t\tRCECLastBus=%02x RCECFirstBus=%02x\n",
> +    BITS(busn, 16, 8),
> +    BITS(busn, 8, 8));

The spec term is "RCEC *Next* Bus", not "RCEC First Bus".

Maybe print these in the "Next Last" order so it comes out like a bus
number range when enabled?

The example below ("RCECLastBus=00 RCECFirstBus=ff") is actually the
case when there are no additional bus numbers associated with this
RCEC.  show_range() handles a similar case by printing "[disabled]"
(as well as the raw numbers in the "enabled" or "verbose > 2" cases).
"[disabled]" wouldn't be quite right here, but maybe "[none]"?

Could be

  AssociatedBusNumbers: 01-07
  AssociatedBusNumbers: [none]              # -vv case
  AssociatedBusNumbers: ff-00 [none]        # -vvv case

But maybe that's applying too much interpretation.  We don't do
anything so fancy for bridge secondary/subordinate bus numbers, for
example.

> +}
> +
>  static void
>  cap_dvsec_cxl(struct device *d, int where)
>  {
> @@ -991,8 +1037,8 @@ show_ext_caps(struct device *d, int type)
>  	  case PCI_EXT_CAP_ID_RCILINK:
>  	    printf("Root Complex Internal Link <?>\n");
>  	    break;
> -	  case PCI_EXT_CAP_ID_RCECOLL:
> -	    printf("Root Complex Event Collector <?>\n");
> +	  case PCI_EXT_CAP_ID_RCEC:
> +	    cap_rcec(d, where);
>  	    break;
>  	  case PCI_EXT_CAP_ID_MFVC:
>  	    printf("Multi-Function Virtual Channel <?>\n");
> diff --git a/setpci.c b/setpci.c
> index 90ca726..2cb70fa 100644
> --- a/setpci.c
> +++ b/setpci.c
> @@ -350,7 +350,7 @@ static const struct reg_name pci_reg_names[] = {
>    { 0x20004,	0, 0, "ECAP_PB" },
>    { 0x20005,	0, 0, "ECAP_RCLINK" },
>    { 0x20006,	0, 0, "ECAP_RCILINK" },
> -  { 0x20007,	0, 0, "ECAP_RCECOLL" },
> +  { 0x20007,	0, 0, "ECAP_RCEC" },
>    { 0x20008,	0, 0, "ECAP_MFVC" },
>    { 0x20009,	0, 0, "ECAP_VC2" },
>    { 0x2000a,	0, 0, "ECAP_RBCB" },
> diff --git a/tests/cap-rcec b/tests/cap-rcec
> new file mode 100644
> index 0000000..4196228
> --- /dev/null
> +++ b/tests/cap-rcec
> @@ -0,0 +1,299 @@
> +6a:00.4 Generic system peripheral [0807]: Intel Corporation Device 0b23
> +        Subsystem: Intel Corporation Device 0000
> +        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> +        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> +        Interrupt: pin A routed to IRQ 255
> +        NUMA node: 0
> +        Capabilities: [40] Express (v2) Root Complex Event Collector, MSI 00
> +                DevCap: MaxPayload 512 bytes, PhantFunc 0
> +                        ExtTag- RBE-
> +                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
> +                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> +                        MaxPayload 128 bytes, MaxReadReq 128 bytes
> +                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> +                RootCap: CRSVisible-
> +                RootCtl: ErrCorrectable+ ErrNon-Fatal+ ErrFatal+ PMEIntEna- CRSVisible-
> +                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> +                DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
> +                         10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
> +                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> +                         FRS-
> +                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
> +        Capabilities: [80] Power Management version 3
> +                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> +                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> +        Capabilities: [90] MSI: Enable- Count=1/1 Maskable+ 64bit-
> +                Address: 00000000  Data: 0000
> +                Masking: 00000000  Pending: 00000000
> +        Capabilities: [100 v1] Advanced Error Reporting
> +                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> +                UEMsk:  DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
> +                UESvrt: DLP+ SDES- TLP+ FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> +                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> +                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> +                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
> +                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> +                HeaderLog: 00000000 00000000 00000000 00000000
> +                RootCmd: CERptEn- NFERptEn- FERptEn-
> +                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
> +                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
> +                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
> +        Capabilities: [160 v2] Root Complex Event Collector Endpoint Association
> +                RCiEPBitmap: RCiEP at Device(s): 0, 1, 4, 7, 8, 9, 10, 12, 13
> +                RCECLastBus=00 RCECFirstBus=ff
> +00: 86 80 23 0b 00 01 10 00 00 00 07 08 00 00 00 00
> +10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
> +30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> +40: 10 80 a2 00 02 00 00 00 07 00 00 00 00 00 00 00
> +50: 00 00 00 00 00 00 00 00 00 00 00 00 07 00 00 00
> +60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +80: 01 90 03 00 00 00 00 00 00 00 00 00 00 00 00 00
> +90: 05 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00
> +a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +d0: 31 6a 08 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +100: 01 00 01 16 00 00 00 00 20 00 10 00 10 30 46 00
> +110: 00 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00
> +120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +160: 07 00 02 00 00 00 00 00 00 ff 00 00 00 00 00 00
> +170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +260: 00 00 00 00 07 00 00 00 00 00 00 00 00 00 00 00
> +270: 00 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00
> +280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +2a0: 00 00 00 00 00 00 00 00 20 00 18 00 20 00 18 00
> +2b0: 20 00 18 00 00 00 00 00 00 00 00 00 00 00 00 00
> +2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +2f0: 00 20 00 00 00 20 00 00 00 20 00 00 00 e0 00 00
> +300: 00 e0 00 00 00 e0 00 00 00 e0 00 00 00 e0 00 00
> +310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +410: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +600: 44 00 00 00 91 00 00 00 00 00 00 00 00 00 00 00
> +610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +680: 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> --
> 2.27.0
> 
