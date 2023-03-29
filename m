Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42666CD9DB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 15:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjC2NCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 09:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjC2NCu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 09:02:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BBE139
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2023 06:02:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso16052488pjb.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2023 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680094966;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VLHjyKqMJYKZrp1MHqySZDYe1F1A7th52vgdpDMrBgU=;
        b=Ul+omYxuiCtivXL3anxOeWUcNgi8WbSGfCsXE0berdrDDV8kGYycbF2pGlnt610FTH
         smPW7o01JqgeEtMW2AlL00CQbm3h3uW4p1zSNY+7bjYeMl7FS74HHHMcCDnrgnmkJaWo
         6fXvOok9ANGXNr0sy3Ul3ifGyXzreKpEWov7T4wgMFdQMyJZrjNWKO0fxbL2gVBots9h
         NkMZL/8Z3bsBDmNBm5JUoB5tG9GJa4e/FftpGgfUnLG2Nqn6PHh41IwyWScLOR+p6Lye
         t/f49GSxaSI6JzlYIrNOznA0ueYID05NYgLWODwtpCpgE8hfrB3KU7O54ULKpz+s+H5Y
         m1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094966;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLHjyKqMJYKZrp1MHqySZDYe1F1A7th52vgdpDMrBgU=;
        b=rj0RzsPqWGEzNesTi8iF77+R0ymzR4l+8zLviSDGT+TNuL6wMlDGsXgPnsp8SXTO+i
         2dqA9Cj9ZzUIKJUxAz+Lq0Ir2VZQDXwYMkmJEXCi8UrGD49HAHlcBHTlrwYYSvu2Y+tm
         p1eCTEFadqsAx0Hjshyy6llmycPi1yqzEKBul/atgdAtYxO7SvnyCEyP1zGE+er6bKah
         wdGcR4hwmAINNOSOXx7rVDmo9HYHNdKW8Mxh+LJ8H/3+lm4SXVtcLC2gWHht+CiqNMX8
         c89SjW0VCDLdMnIG3/hzYWTrYzC3Sl78f7VEVXg0630kJAbcD2BhfhMHZigx4YPov+y/
         MPcA==
X-Gm-Message-State: AAQBX9eVZXz24gm6eyCvJq7qFzVTBQL9G+L1UNs/FXOovXliHM1O+xx8
        7nzDto67qRvfERpdq+P6vmSY
X-Google-Smtp-Source: AKy350ZDVjbstg/QL4QGtDnz7jL0TJMSWTa+RY3jeewKPpM7zdgI9KJ7ETXCdwqKv4pyu/kjoFXjxQ==
X-Received: by 2002:a17:902:ec82:b0:1a1:8d4e:a71d with SMTP id x2-20020a170902ec8200b001a18d4ea71dmr26392325plg.46.1680094965778;
        Wed, 29 Mar 2023 06:02:45 -0700 (PDT)
Received: from thinkpad ([117.216.120.213])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b0019edb3ae415sm23012008pls.14.2023.03.29.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:02:45 -0700 (PDT)
Date:   Wed, 29 Mar 2023 18:32:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_krichai@quicinc.com" <quic_krichai@quicinc.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
        "steev@kali.org" <steev@kali.org>,
        "mka@chromium.org" <mka@chromium.org>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [EXT] [PATCH v3 1/1] PCI: qcom: Add support for system suspend
 and resume
Message-ID: <20230329130237.GC5575@thinkpad>
References: <20230327133824.29136-1-manivannan.sadhasivam@linaro.org>
 <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
 <AM6PR04MB4838C84574BE534DDB0428D0888B9@AM6PR04MB4838.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB4838C84574BE534DDB0428D0888B9@AM6PR04MB4838.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 27, 2023 at 03:29:54PM +0000, Frank Li wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: Monday, March 27, 2023 8:38 AM
> > To: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org
> > Cc: andersson@kernel.org; konrad.dybcio@linaro.org;
> > bhelgaas@google.com; linux-pci@vger.kernel.org; linux-arm-
> > msm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > quic_krichai@quicinc.com; johan+linaro@kernel.org; steev@kali.org;
> > mka@chromium.org; Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>; Dhruva Gole <d-gole@ti.com>
> > Subject: [EXT] [PATCH v3 1/1] PCI: qcom: Add support for system suspend
> > and resume
> > 
> > Caution: EXT Email
> > 
> > During the system suspend, vote for minimal interconnect bandwidth and
> > also turn OFF the resources like clock and PHY if there are no active
> > devices connected to the controller. For the controllers with active
> > devices, the resources are kept ON as removing the resources will
> > trigger access violation during the late end of suspend cycle as kernel
> > tries to access the config space of PCIe devices to mask the MSIs.
> 
> I remember I met similar problem before. It is relate ASPM settings of NVME.
> NVME try to use L1.2 at suspend to save restore time. 
> 
> It should be user decided if PCI enter L1.2( for better resume time) or L2
> For batter power saving.  If NVME disable ASPM,  NVME driver will free
> Msi irq before enter suspend,  so not issue access config space by MSI
> Irq disable function. 
> 

The NVMe driver will only shutdown the device if ASPM is completely disabled in
the kernel. They also take powerdown path for some Intel platforms though. For
others, they keep the device in power on state and expect power saving with
ASPM.

> This is just general comment. It is not specific for this patches.  Many platform
> Will face the similar problem.  Maybe need better solution to handle
> L2/L3 for better power saving in future. 
> 

The only argument I hear from them is that, when the NVMe device gets powered
down during suspend, then it may detoriate the life time of it as the suspend
cycle is going to be high.

- Mani

> Frank Li
>  
> > 
> > Also, it is not desirable to put the link into L2/L3 state as that
> > implies VDD supply will be removed and the devices may go into powerdown
> > state. This will affect the lifetime of storage devices like NVMe.
> > 
> > And finally, during resume, turn ON the resources if the controller was
> > truly suspended (resources OFF) and update the interconnect bandwidth
> > based on PCIe Gen speed.
> > 
> > Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > Acked-by: Dhruva Gole <d-gole@ti.com>
> > Signed-off-by: Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 62 ++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> > b/drivers/pci/controller/dwc/pcie-qcom.c
> > index a232b04af048..f33df536d9be 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -227,6 +227,7 @@ struct qcom_pcie {
> >         struct gpio_desc *reset;
> >         struct icc_path *icc_mem;
> >         const struct qcom_pcie_cfg *cfg;
> > +       bool suspended;
> >  };
> > 
> >  #define to_qcom_pcie(x)                dev_get_drvdata((x)->dev)
> > @@ -1820,6 +1821,62 @@ static int qcom_pcie_probe(struct
> > platform_device *pdev)
> >         return ret;
> >  }
> > 
> > +static int qcom_pcie_suspend_noirq(struct device *dev)
> > +{
> > +       struct qcom_pcie *pcie = dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       /*
> > +        * Set minimum bandwidth required to keep data path functional during
> > +        * suspend.
> > +        */
> > +       ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
> > +       if (ret) {
> > +               dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       /*
> > +        * Turn OFF the resources only for controllers without active PCIe
> > +        * devices. For controllers with active devices, the resources are kept
> > +        * ON and the link is expected to be in L0/L1 (sub)states.
> > +        *
> > +        * Turning OFF the resources for controllers with active PCIe devices
> > +        * will trigger access violation during the end of the suspend cycle,
> > +        * as kernel tries to access the PCIe devices config space for masking
> > +        * MSIs.
> > +        *
> > +        * Also, it is not desirable to put the link into L2/L3 state as that
> > +        * implies VDD supply will be removed and the devices may go into
> > +        * powerdown state. This will affect the lifetime of the storage devices
> > +        * like NVMe.
> > +        */
> > +       if (!dw_pcie_link_up(pcie->pci)) {
> > +               qcom_pcie_host_deinit(&pcie->pci->pp);
> > +               pcie->suspended = true;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int qcom_pcie_resume_noirq(struct device *dev)
> > +{
> > +       struct qcom_pcie *pcie = dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       if (pcie->suspended) {
> > +               ret = qcom_pcie_host_init(&pcie->pci->pp);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               pcie->suspended = false;
> > +       }
> > +
> > +       qcom_pcie_icc_update(pcie);
> > +
> > +       return 0;
> > +}
> > +
> >  static const struct of_device_id qcom_pcie_match[] = {
> >         { .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> >         { .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > @@ -1856,12 +1913,17 @@
> > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302,
> > qcom_fixup_class);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000,
> > qcom_fixup_class);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001,
> > qcom_fixup_class);
> > 
> > +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> > +       NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq,
> > qcom_pcie_resume_noirq)
> > +};
> > +
> >  static struct platform_driver qcom_pcie_driver = {
> >         .probe = qcom_pcie_probe,
> >         .driver = {
> >                 .name = "qcom-pcie",
> >                 .suppress_bind_attrs = true,
> >                 .of_match_table = qcom_pcie_match,
> > +               .pm = &qcom_pcie_pm_ops,
> >         },
> >  };
> >  builtin_platform_driver(qcom_pcie_driver);
> > --
> > 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
