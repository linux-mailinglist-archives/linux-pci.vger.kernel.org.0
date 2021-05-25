Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A18B390B02
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 23:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhEYVHf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 17:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhEYVHe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 17:07:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F52C061574
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 14:06:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q5so33610567wrs.4
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjwDwrf7ZVSWZAT3ldL1+QhlVhZZoRN4X8LWYKC/QPg=;
        b=Nan568JOP3TgEgPONnxVCxajk0muaVQQyGdGpKDJISnB8qgwAZqErW+cIYzVg9JMjL
         sagNFviPKtBP+hHP5xRRvNJu07QzRYRS2cVj7+T7BqwaPIIY0nuP/y2PM11zBcB2wu9W
         4RbV7SKzW5D8BlPCmcg0iBpN/3ZjqnnupzlVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjwDwrf7ZVSWZAT3ldL1+QhlVhZZoRN4X8LWYKC/QPg=;
        b=Zpdh6IXPSaW0u8qALhsBwuc101kEQ+CmsQybyShke5j+6oEl4PQeCjUUvojuNW2d9n
         exCpttjCP26kyrnP5tNnM4e2dGGzme25+5OlwIswJkW3amfcGgHAo/Xj2pOkZ50F74u7
         qT5LOD/nKeaozn9U0F2dpeBZkGnn/2gQFu7gf2wvu2GcXZ0nFElYecdMQEIGzX+YKQLp
         6+E1zKA0FO2qu4vIA7DeAPfefCRtWbB5bg+KyOeYPxTvXFM20ptlz/djvFqfSyAkOD01
         ZXw1+j8ANpG29XuBJi9meWMZPCnQhZxeAGIheP+mTU17CKl+z5/FrBsHs4q+6QsUDACP
         CGKg==
X-Gm-Message-State: AOAM531HN0UBqxkdjNcSLzhls4KjbiLDtI6Fn2R+EdeVqnsRaTlJY0Q9
        +HBBJlJWy+2/TFZXlPp/OoiU9k/rU0hH56q77HGTmA==
X-Google-Smtp-Source: ABdhPJyuhKf4Q5Z31If2FB7euKvjehR9HZdhc8AM8chdkiF8eV23PFSAYUVqF3+1Oy8boI5QTpVGmy4ov3owhlGsFrU=
X-Received: by 2002:adf:e4c8:: with SMTP id v8mr29586284wrm.345.1621976762669;
 Tue, 25 May 2021 14:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210427175140.17800-4-jim2101024@gmail.com> <20210525204057.GA1227343@bjorn-Precision-5520>
In-Reply-To: <20210525204057.GA1227343@bjorn-Precision-5520>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 25 May 2021 17:05:51 -0400
Message-ID: <CA+-6iNzDCXokrHjVL=vdTT=cMV52tSSk9=L7h8QsCA=sf1pZiw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] PCI: brcmstb: Add panic/die handler to RC driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000cd0baa05c32de4a8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000cd0baa05c32de4a8
Content-Type: text/plain; charset="UTF-8"

On Tue, May 25, 2021 at 4:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Apr 27, 2021 at 01:51:38PM -0400, Jim Quinlan wrote:
> > Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> > by default Broadcom's STB PCIe controller effects an abort.  This simple
> > handler determines if the PCIe controller was the cause of the abort and if
> > so, prints out diagnostic info.
> >
> > Example output:
> >   brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
> >   brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0
>
> What happens to the driver that performed the illegal access?

The entire system dies from the abort.  Some customers elect to do a
fixup in the abort handler but we admonish them to fix the root cause.
With these patches we at least get immediate information about the
access that caused the abort.
>
>
> Does this mean that errors that are recoverable on other hardware (by
> noticing the 0xffffffff and checking for error) are fatal on the
> Broadcom STB?

Yes.  For example, I have an old Rocketport RP2 card I sometimes use
for testing.   On a Broadcom STB it dies when the rp2 probe does a
read after calling rp2_reset_asic().  On an x86, 0xffffffff is
returned on this read and all is well.

I don't think there is any PCIe spec that mandates an access error
returns 0xffffffff.  Some of our SOCs have a new feature where we can
return the 0xffffffff instead of getting an abort.  We will allow the
customer to turn this on if they ask for it, but for the time being we
prefer an abort as many drivers do not check for 0xffffffff.

Regards,
Jim Quinlan
Broadcom STB
>
>
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 122 ++++++++++++++++++++++++++
> >  1 file changed, 122 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 3b6a62dd2e72..d3af8d84f0d6 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -12,11 +12,13 @@
> >  #include <linux/ioport.h>
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/kdebug.h>
> >  #include <linux/kernel.h>
> >  #include <linux/list.h>
> >  #include <linux/log2.h>
> >  #include <linux/module.h>
> >  #include <linux/msi.h>
> > +#include <linux/notifier.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_pci.h>
> > @@ -184,6 +186,39 @@
> >  #define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK          0x1
> >  #define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT         0x0
> >
> > +/* Error report regiseters */
> > +#define PCIE_OUTB_ERR_TREAT                          0x6000
> > +#define  PCIE_OUTB_ERR_TREAT_CONFIG_MASK             0x1
> > +#define  PCIE_OUTB_ERR_TREAT_MEM_MASK                        0x2
> > +#define PCIE_OUTB_ERR_VALID                          0x6004
> > +#define PCIE_OUTB_ERR_CLEAR                          0x6008
> > +#define PCIE_OUTB_ERR_ACC_INFO                               0x600c
> > +#define  PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK         0x01
> > +#define  PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK         0x02
> > +#define  PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK         0x04
> > +#define  PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK               0x10
> > +#define  PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK              0xff00
> > +#define PCIE_OUTB_ERR_ACC_ADDR                               0x6010
> > +#define PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK                      0xff00000
> > +#define PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK                      0xf8000
> > +#define PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK             0x7000
> > +#define PCIE_OUTB_ERR_ACC_ADDR_REG_MASK                      0xfff
> > +#define PCIE_OUTB_ERR_CFG_CAUSE                              0x6014
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK                0x40
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK          0x20
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK     0x10
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK    0x4
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK   0x2
> > +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK     0x1
> > +#define PCIE_OUTB_ERR_MEM_ADDR_LO                    0x6018
> > +#define PCIE_OUTB_ERR_MEM_ADDR_HI                    0x601c
> > +#define PCIE_OUTB_ERR_MEM_CAUSE                              0x6020
> > +#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK                0x40
> > +#define  PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK          0x20
> > +#define  PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK     0x10
> > +#define  PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK   0x2
> > +#define  PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK               0x1
> > +
> >  /* Forward declarations */
> >  struct brcm_pcie;
> >  static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val);
> > @@ -215,6 +250,7 @@ struct pcie_cfg_data {
> >       const enum pcie_type type;
> >       void (*perst_set)(struct brcm_pcie *pcie, u32 val);
> >       void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> > +     const bool has_err_report;
> >  };
> >
> >  static const int pcie_offsets[] = {
> > @@ -262,6 +298,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
> >       .type           = BCM7278,
> >       .perst_set      = brcm_pcie_perst_set_7278,
> >       .bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
> > +     .has_err_report = true,
> >  };
> >
> >  struct brcm_msi {
> > @@ -302,8 +339,87 @@ struct brcm_pcie {
> >       u32                     hw_rev;
> >       void                    (*perst_set)(struct brcm_pcie *pcie, u32 val);
> >       void                    (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> > +     bool                    has_err_report;
> > +     struct notifier_block   die_notifier;
> >  };
> >
> > +/* Dump out PCIe errors on die or panic */
> > +static int dump_pcie_error(struct notifier_block *self, unsigned long v, void *p)
> > +{
> > +     const struct brcm_pcie *pcie = container_of(self, struct brcm_pcie, die_notifier);
> > +     void __iomem *base = pcie->base;
> > +     int i, is_cfg_err, is_mem_err, lanes;
> > +     char *width_str, *direction_str, lanes_str[9];
> > +     u32 info;
> > +
> > +     if (readl(base + PCIE_OUTB_ERR_VALID) == 0)
> > +             return NOTIFY_DONE;
> > +     info = readl(base + PCIE_OUTB_ERR_ACC_INFO);
> > +
> > +
> > +     is_cfg_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK);
> > +     is_mem_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK);
> > +     width_str = (info & PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK) ? "64bit" : "32bit";
> > +     direction_str = (info & PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK) ? "Write" : "Read";
> > +     lanes = FIELD_GET(PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK, info);
> > +     for (i = 0, lanes_str[8] = 0; i < 8; i++)
> > +             lanes_str[i] = (lanes & (1 << i)) ? '1' : '0';
> > +
> > +     if (is_cfg_err) {
> > +             u32 cfg_addr = readl(base + PCIE_OUTB_ERR_ACC_ADDR);
> > +             u32 cause = readl(base + PCIE_OUTB_ERR_CFG_CAUSE);
> > +             int bus = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK, cfg_addr);
> > +             int dev = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK, cfg_addr);
> > +             int func = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK, cfg_addr);
> > +             int reg = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_REG_MASK, cfg_addr);
> > +
> > +             dev_err(pcie->dev, "Error: CFG Acc, %s, %s, Bus=%d, Dev=%d, Fun=%d, Reg=0x%x, lanes=%s\n",
> > +                     width_str, direction_str, bus, dev, func, reg, lanes_str);
> > +             dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccTO=%d AccDsbld=%d Acc64bit=%d\n",
> > +                     !!(cause & PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK),
> > +                     !!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK),
> > +                     !!(cause & PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK),
> > +                     !!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK),
> > +                     !!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK),
> > +                     !!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK));
> > +     }
> > +
> > +     if (is_mem_err) {
> > +             u32 cause = readl(base + PCIE_OUTB_ERR_MEM_CAUSE);
> > +             u32 lo = readl(base + PCIE_OUTB_ERR_MEM_ADDR_LO);
> > +             u32 hi = readl(base + PCIE_OUTB_ERR_MEM_ADDR_HI);
> > +             u64 addr = ((u64)hi << 32) | (u64)lo;
> > +
> > +             dev_err(pcie->dev, "Error: Mem Acc, %s, %s, @0x%llx, lanes=%s\n",
> > +                     width_str, direction_str, addr, lanes_str);
> > +             dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccDsble=%d BadAddr=%d\n",
> > +                     !!(cause & PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK),
> > +                     !!(cause & PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK),
> > +                     !!(cause & PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK),
> > +                     !!(cause & PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK),
> > +                     !!(cause & PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK));
> > +     }
> > +
> > +     /* Clear the error */
> > +     writel(1, base + PCIE_OUTB_ERR_CLEAR);
> > +
> > +     return NOTIFY_DONE;
> > +}
> > +
> > +static void brcm_register_die_notifiers(struct brcm_pcie *pcie)
> > +{
> > +     pcie->die_notifier.notifier_call = dump_pcie_error;
> > +     register_die_notifier(&pcie->die_notifier);
> > +     atomic_notifier_chain_register(&panic_notifier_list, &pcie->die_notifier);
> > +}
> > +
> > +static void brcm_unregister_die_notifiers(struct brcm_pcie *pcie)
> > +{
> > +     unregister_die_notifier(&pcie->die_notifier);
> > +     atomic_notifier_chain_unregister(&panic_notifier_list, &pcie->die_notifier);
> > +     pcie->die_notifier.notifier_call = NULL;
> > +}
> > +
> >  /*
> >   * This is to convert the size of the inbound "BAR" region to the
> >   * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
> > @@ -1216,6 +1332,8 @@ static int brcm_pcie_remove(struct platform_device *pdev)
> >       struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> >
> >       pci_stop_root_bus(bridge->bus);
> > +     if (pcie->has_err_report)
> > +             brcm_unregister_die_notifiers(pcie);
> >       pci_remove_root_bus(bridge->bus);
> >       __brcm_pcie_remove(pcie);
> >
> > @@ -1255,6 +1373,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >       pcie->np = np;
> >       pcie->reg_offsets = data->offsets;
> >       pcie->type = data->type;
> > +     pcie->has_err_report = data->has_err_report;
> >       pcie->perst_set = data->perst_set;
> >       pcie->bridge_sw_init_set = data->bridge_sw_init_set;
> >
> > @@ -1322,6 +1441,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >
> >       platform_set_drvdata(pdev, pcie);
> >
> > +     if (pcie->has_err_report)
> > +             brcm_register_die_notifiers(pcie);
> > +
> >       return pci_host_probe(bridge);
> >  fail:
> >       __brcm_pcie_remove(pcie);
> > --
> > 2.17.1
> >

--000000000000cd0baa05c32de4a8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbgYJKoZIhvcNAQcCoIIQXzCCEFsCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3FMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU0wggQ1oAMCAQICDCPgI/V0ZP8BXsW/fzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNjU4MTRaFw0yMjA5MDUwNzA4NDRaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFDASBgNVBAMTC0ppbSBRdWlubGFuMSkwJwYJKoZIhvcNAQkB
FhpqYW1lcy5xdWlubGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBANFi+GVatHc2ko+fxmheE2Z9v2FqyTUbRaMZ7ACvPf85cdFDEii6Q3zRndOqzyDc5ExtFkMY
edssm6LsVIvAoMA3HtdjnW4UK6h4nQwerDCJu1VTTesrnJHGwGvIvrHbnc9esAE7/j2bRYIhfmSu
6zDhwIb5POOvLpF7xcu/EEH8Yzvyi7qNfMY+j93e5PiRfC602f/XYK8LrF3a91GiGXSEBoTLeMge
LeylbuEJGL9I80yqq8e6Z+Q6ulLxa6SopzpoysJe/vEVHgp9jPNppZzwKngVd2iDBRqpKlCngIAM
DXgVGyEojXnuEbRs3NlB7wq1kJGlYysrnDug55ncJM8CAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFCeTeUYv84Mo3T1V+OyDdxib
DDLvMA0GCSqGSIb3DQEBCwUAA4IBAQCCqR1PBVtHPvQHuG8bjMFQ94ZB7jmFEGhgfAsFJMaSMLov
qyt8DKr8suCYF4dKGzqalbxo5QU9mmZXdLifqceHdt/Satxb+iGJjBhZg4E0cDds24ofYq+Lbww2
YlIKC2HHxIN+JX2mFpavSXkshR5GT29B9EIJ8hgSjbs61XXeAcrmVIDfYbXQEmGbsnwqxdq+DJpQ
S2kM2wvSlgSWDb6pL7myuKR5lCkQhj7piGSgrVLJRDRrMPw1L4MvnV9DjUFMlGCB40Hm6xqn/jm0
8FCLlWhxve5mj+hgUOPETiKbjhCxJhhAPDdCvDRkZtJlQ8oxUVvXHugG8jm1YqB5AWx7MYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMI+Aj9XRk/wFexb9/
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBRJiFvk8P3JTRtyYwR1amVnOrfFM9n
XwQ8yzHOlFfnrDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA1
MjUyMTA2MDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAXXglDq6d9FbuV2z0QWjFgvEdTeyzjzH7p2JDfPGOvEGLMKCx
r/xex34qsIWGrP9fa7lS1pLTB5y4+o+j4q1wcd8XUggSdly+0OiyWCG83/FYIB/z9w+0xNshjf2u
2r1VDYWZyr1jT9aQIIf6SD5WS11nwCb/D9ABAaVRI+Ty+pHd3Tt3pWFmk4jZCiokM+G168C+uAdQ
OSC4PwrA/EW2zMZ6drddH2qBx4PddBc/9jOcnUwKI/a1NNsJKw7ODICJVh8U0oTC8EBAJUCOsC7+
qW9i4hpV8oH3bkIWetFbQuKX1O0cOefjlGMOog9+56Z++090SOYMMPBxqvGv+PmCqw==
--000000000000cd0baa05c32de4a8--
