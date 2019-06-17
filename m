Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C72C480AD
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 13:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfFQL3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 07:29:43 -0400
Received: from foss.arm.com ([217.140.110.172]:46288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfFQL3n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 07:29:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7936B344;
        Mon, 17 Jun 2019 04:29:42 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 030E33F246;
        Mon, 17 Jun 2019 04:31:26 -0700 (PDT)
Date:   Mon, 17 Jun 2019 12:29:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lftan.linux@gmail.com
Subject: Re: [PATCH v2] PCI: altera: Fix configuration type based on
 secondary number
Message-ID: <20190617112939.GB24968@e121166-lin.cambridge.arm.com>
References: <1560321720-4083-1-git-send-email-ley.foon.tan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560321720-4083-1-git-send-email-ley.foon.tan@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 12, 2019 at 02:42:00PM +0800, Ley Foon Tan wrote:
> This fix issue when access config from PCIe switch.
> 
> Stratix 10 PCIe controller does not support Type 1 to Type 0 conversion
> as previous version (V1) does.
> 
> The PCIe controller need to send Type 0 config TLP if the targeting bus
> matches with the secondary bus number, which is when the TLP is targeting
> the immediate device on the link.
> 
> The PCIe controller send Type 1 config TLP if the targeting bus is
> larger than the secondary bus, which is when the TLP is targeting the
> device not immediate on the link.
> 
> Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> 
> ---
> v2:
> - Add get_tlp_header() function.
> ---
>  drivers/pci/controller/pcie-altera.c | 41 ++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 14 deletions(-)

Applied to pci/altera for v5.3, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index 27222071ace7..d2497ca43828 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -44,6 +44,8 @@
>  #define S10_RP_RXCPL_STATUS		0x200C
>  #define S10_RP_CFG_ADDR(pcie, reg)	\
>  	(((pcie)->hip_base) + (reg) + (1 << 20))
> +#define S10_RP_SECONDARY(pcie)		\
> +	readb(S10_RP_CFG_ADDR(pcie, PCI_SECONDARY_BUS))
>  
>  /* TLP configuration type 0 and 1 */
>  #define TLP_FMTTYPE_CFGRD0		0x04	/* Configuration Read Type 0 */
> @@ -55,14 +57,9 @@
>  #define TLP_WRITE_TAG			0x10
>  #define RP_DEVFN			0
>  #define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
> -#define TLP_CFGRD_DW0(pcie, bus)					\
> -	((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgrd0		\
> -				: pcie->pcie_data->cfgrd1) << 24) |	\
> -				TLP_PAYLOAD_SIZE)
> -#define TLP_CFGWR_DW0(pcie, bus)					\
> -	((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgwr0		\
> -				: pcie->pcie_data->cfgwr1) << 24) |	\
> -				TLP_PAYLOAD_SIZE)
> +#define TLP_CFG_DW0(pcie, cfg)		\
> +		(((cfg) << 24) |	\
> +		  TLP_PAYLOAD_SIZE)
>  #define TLP_CFG_DW1(pcie, tag, be)	\
>  	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
>  #define TLP_CFG_DW2(bus, devfn, offset)	\
> @@ -322,14 +319,31 @@ static void s10_tlp_write_packet(struct altera_pcie *pcie, u32 *headers,
>  	s10_tlp_write_tx(pcie, data, RP_TX_EOP);
>  }
>  
> +static void get_tlp_header(struct altera_pcie *pcie, u8 bus, u32 devfn,
> +			   int where, u8 byte_en, bool read, u32 *headers)
> +{
> +	u8 cfg;
> +	u8 cfg0 = read ? pcie->pcie_data->cfgrd0 : pcie->pcie_data->cfgwr0;
> +	u8 cfg1 = read ? pcie->pcie_data->cfgrd1 : pcie->pcie_data->cfgwr1;
> +	u8 tag = read ? TLP_READ_TAG : TLP_WRITE_TAG;
> +
> +	if (pcie->pcie_data->version == ALTERA_PCIE_V1)
> +		cfg = (bus == pcie->root_bus_nr) ? cfg0 : cfg1;
> +	else
> +		cfg = (bus > S10_RP_SECONDARY(pcie)) ? cfg0 : cfg1;
> +
> +	headers[0] = TLP_CFG_DW0(pcie, cfg);
> +	headers[1] = TLP_CFG_DW1(pcie, tag, byte_en);
> +	headers[2] = TLP_CFG_DW2(bus, devfn, where);
> +}
> +
>  static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
>  			      int where, u8 byte_en, u32 *value)
>  {
>  	u32 headers[TLP_HDR_SIZE];
>  
> -	headers[0] = TLP_CFGRD_DW0(pcie, bus);
> -	headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
> -	headers[2] = TLP_CFG_DW2(bus, devfn, where);
> +	get_tlp_header(pcie, bus, devfn, where, byte_en, true,
> +		       headers);
>  
>  	pcie->pcie_data->ops->tlp_write_pkt(pcie, headers, 0, false);
>  
> @@ -342,9 +356,8 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
>  	u32 headers[TLP_HDR_SIZE];
>  	int ret;
>  
> -	headers[0] = TLP_CFGWR_DW0(pcie, bus);
> -	headers[1] = TLP_CFG_DW1(pcie, TLP_WRITE_TAG, byte_en);
> -	headers[2] = TLP_CFG_DW2(bus, devfn, where);
> +	get_tlp_header(pcie, bus, devfn, where, byte_en, false,
> +		       headers);
>  
>  	/* check alignment to Qword */
>  	if ((where & 0x7) == 0)
> -- 
> 2.19.0
> 
