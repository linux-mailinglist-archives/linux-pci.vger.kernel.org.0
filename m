Return-Path: <linux-pci+bounces-2200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E822082EC46
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 10:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9725E1C22302
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C44134C9;
	Tue, 16 Jan 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLpDaHQP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A7F134AD
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbe344a6cf4so7980752276.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 01:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705398929; x=1706003729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HHceE+8ZgnCKJFtFOX9khVW52ZhVdYcLB1ywYIuNgN4=;
        b=LLpDaHQPkUpVm1BCMe17XST2VisW6pmwYSNyLNyhMzx2cRLEQIRamkkaN94KF1IT/5
         F2jIqJ2CLk7VPL7167n7SnN95Et5xpw+kQLr1CpUr5ijUS2ZcuwerlwhVrqEXfOHpVYP
         ddoS8UrVOV2/rcz3xpgV7IYvy+tOdn6/jB+vOhUcVuwiHSISupMQ8gwUPPcJjyzXtABV
         ksv5o99KGOt/mxdiVF7nUlKt6EfWa8L5ncmOTV2+qaA+mu/eVf4NBhTlrv6/6PnbIIRp
         eH2V1ERGvu+LtxC3u5XR6NaudEkJBRO4Vr1HISpVAiWKLv7pZgku51V3Wk1bkY+lzkNQ
         wyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705398929; x=1706003729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHceE+8ZgnCKJFtFOX9khVW52ZhVdYcLB1ywYIuNgN4=;
        b=K9moIOxii9AzNC7wPRTGtYDUWK2zI/kpEHQ+gYjc/obWVmFvfacCMVm+LS9DjxXlRJ
         8iNhMd9g7S/VShQ8CnBrl4fLgUPoNKhj4WeXAoeKdsUApUXAGlfGaGfaXYlIVUH1h9ub
         c1vAvM4m+Zk8iz6UP6OPt2nZ+ErKlRPF7sDBr5VmItx0TD1imFvS1E7O83o86iUxeUb6
         tLFxrf5AJQMQUxn0wK0FI5V0w+fVP0zgpXndAtL9P8NdjucmfTYbVHfb19vZff4g5YjP
         SyRkTBgxSReFBAFMPdEFDdJaj2scudcXIodq4cInPWtXOsYFDi4FpDTnKT7bDWM7feBt
         MDxw==
X-Gm-Message-State: AOJu0YwT7Ln/iq9aDOd4+KxzhdOackPD08TXcp+Y1Vn0wgPrtZu7fytR
	/xtSwJfYr3/B3PuCi6jS8KQNbqE2BrAxOwhx1V16HYzVOwp47w==
X-Google-Smtp-Source: AGHT+IFtCf/hMaCskLdNHnMO1jUJkrx/GDEVrX+l3/JGOfSdT388wHkJ38igSfBgECB27FyVDQSBSTQOTz5l6xRZP5g=
X-Received: by 2002:a25:c548:0:b0:dbd:f9c5:5d6b with SMTP id
 v69-20020a25c548000000b00dbdf9c55d6bmr4380192ybe.79.1705398928959; Tue, 16
 Jan 2024 01:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com> <CAA8EJpqwOfeS-QpLVvYGf0jmTVxiT02POwK+9tkN03Cr4DgL+g@mail.gmail.com>
 <da1945ce-7e34-6ad5-7b9b-478fcbd4a2c6@quicinc.com>
In-Reply-To: <da1945ce-7e34-6ad5-7b9b-478fcbd4a2c6@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Jan 2024 11:55:17 +0200
Message-ID: <CAA8EJpoZakDcBXYE57bRPMFvGEXh1o82r7Znv8mwCK6mRf5xog@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org, vireshk@kernel.org, 
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com, 
	quic_nitegupt@quicinc.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jan 2024 at 07:17, Krishna Chaitanya Chundru
<quic_krichai@quicinc.com> wrote:
>
>
>
> On 1/12/2024 9:03 PM, Dmitry Baryshkov wrote:
> > On Fri, 12 Jan 2024 at 16:25, Krishna chaitanya chundru
> > <quic_krichai@quicinc.com> wrote:
> >>
> >> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> >> maintains hardware state of a regulator by performing max aggregation of
> >> the requests made by all of the processors.
> >>
> >> PCIe controller can operate on different RPMh performance state of power
> >> domain based up on the speed of the link. And this performance state varies
> >> from target to target.
> >>
> >> It is manadate to scale the performance state based up on the PCIe speed
> >> link operates so that SoC can run under optimum power conditions.
> >>
> >> Add Operating Performance Points(OPP) support to vote for RPMh state based
> >> upon GEN speed link is operating.
> >>
> >> OPP can handle ICC bw voting also, so move icc bw voting through opp
> >> framework if opp entries are present.
> >>
> >> In PCIe certain gen speeds like GEN1x2 & GEN2X1 or GEN3x2 & GEN4x1 use
> >> same icc bw and has frequency, so use frequency based search to reduce
> >> number of entries in the opp table.
> >>
> >> Don't initialize icc if opp is supported.
> >>
> >> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> >> ---
> >>   drivers/pci/controller/dwc/pcie-qcom.c | 83 ++++++++++++++++++++++++++++------
> >>   1 file changed, 70 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >> index 035953f0b6d8..31512dc9d6ff 100644
> >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> @@ -22,6 +22,7 @@
> >>   #include <linux/of.h>
> >>   #include <linux/of_gpio.h>
> >>   #include <linux/pci.h>
> >> +#include <linux/pm_opp.h>
> >>   #include <linux/pm_runtime.h>
> >>   #include <linux/platform_device.h>
> >>   #include <linux/phy/pcie.h>
> >> @@ -244,6 +245,7 @@ struct qcom_pcie {
> >>          const struct qcom_pcie_cfg *cfg;
> >>          struct dentry *debugfs;
> >>          bool suspended;
> >> +       bool opp_supported;
> >>   };
> >>
> >>   #define to_qcom_pcie(x)                dev_get_drvdata((x)->dev)
> >> @@ -1404,16 +1406,14 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> >>          return 0;
> >>   }
> >>
> >> -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> >> +static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
> >>   {
> >>          struct dw_pcie *pci = pcie->pci;
> >> -       u32 offset, status;
> >> +       u32 offset, status, freq;
> >> +       struct dev_pm_opp *opp;
> >>          int speed, width;
> >>          int ret;
> >>
> >> -       if (!pcie->icc_mem)
> >> -               return;
> >> -
> >>          offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >>          status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> >>
> >> @@ -1424,11 +1424,42 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> >>          speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> >>          width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> >>
> >> -       ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> >> -       if (ret) {
> >> -               dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> >> -                       ret);
> >> +       if (pcie->opp_supported) {
> >> +               switch (speed) {
> >> +               case 1:
> >> +                       freq = 2500000;
> >> +                       break;
> >> +               case 2:
> >> +                       freq = 5000000;
> >> +                       break;
> >> +               case 3:
> >> +                       freq = 8000000;
> >> +                       break;
> >> +               default:
> >> +                       WARN_ON_ONCE(1);
> >> +                       fallthrough;
> >> +               case 4:
> >> +                       freq = 16000000;
> >
> > I expected that this kind of detail goes to the OPP table itself. Can
> > we index the table using the generation instead of frequency?
> >
> In the previous patch also we tried to use index only, but problem using
> index is we can define only GEN speed. As we are voting for the ICC BW
> voting also we need to consider for lane width while configuring this
> path. It is difficult to use index now as we need to consider both gen
> speed and lane width.
> For that reason we moved to frequencies to reduce number of entries in
> OPP table.
> for example if my controller supports GEN1 & GEN2 and MAX lane width is
> 2.
>
> for GEN1x1
> opp-2500000 {
> };
>
> for GEN2x1 & GEN1x2 as both use same frequiences and bandwidth.
> opp-5000000 {
> };
>
> for GEN2x2
> opp-10000000 {
>
> };

Ack. It would be nice to add this as a comment. Something as simple as
'gen1x2 and gen2x1 share the bandwidth value and thus the opp entry'

>
> - Krishna chaitanya.
> >> +                       break;
> >> +               }
> >> +
> >> +               opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);
> >> +               if (!IS_ERR(opp)) {
> >> +                       ret = dev_pm_opp_set_opp(pci->dev, opp);
> >> +                       if (ret)
> >> +                               dev_err(pci->dev, "Failed to set opp: freq %ld ret %d\n",
> >> +                                       dev_pm_opp_get_freq(opp), ret);
> >> +                       dev_pm_opp_put(opp);
> >> +               }
> >> +       } else {
> >> +               ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> >> +               if (ret) {
> >> +                       dev_err(pci->dev, "failed to set interconnect bandwidth for pcie-mem: %d\n",
> >> +                               ret);
> >> +               }
> >>          }
> >> +
> >> +       return;
> >>   }
> >>
> >>   static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> >> @@ -1471,8 +1502,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
> >>   static int qcom_pcie_probe(struct platform_device *pdev)
> >>   {
> >>          const struct qcom_pcie_cfg *pcie_cfg;
> >> +       unsigned long max_freq = INT_MAX;
> >>          struct device *dev = &pdev->dev;
> >>          struct qcom_pcie *pcie;
> >> +       struct dev_pm_opp *opp;
> >>          struct dw_pcie_rp *pp;
> >>          struct resource *res;
> >>          struct dw_pcie *pci;
> >> @@ -1539,9 +1572,33 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >>                  goto err_pm_runtime_put;
> >>          }
> >>
> >> -       ret = qcom_pcie_icc_init(pcie);
> >> -       if (ret)
> >> +        /* OPP table is optional */
> >> +       ret = devm_pm_opp_of_add_table(dev);
> >> +       if (ret && ret != -ENODEV) {
> >> +               dev_err_probe(dev, ret, "Failed to add OPP table\n");
> >>                  goto err_pm_runtime_put;
> >> +       }
> >
> > Can we initialise the table from the driver if it is not found? This
> > will help us by having the common code later on.
> >
> we already icc voting if there is no opp table present in the dts.

Yes. So later we have two different code paths: one for the OPP table
being present and another one for the absent OPP table. My suggestion
is to initialise minimal OPP table by hand and then have a common code
path in qcom_pcie_icc_update().

> So I think this might not be needed.
> Please let me know if you want to use for some other use case.
>
> - Krishna Chaitanya.
> >> +
> >> +       /* vote for max freq in the opp table if opp table is present */
> >> +       if (ret != -ENODEV) {
> >> +               opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
> >> +               if (!IS_ERR(opp)) {
> >> +                       ret = dev_pm_opp_set_opp(dev, opp);
> >> +                       if (ret)
> >> +                               dev_err_probe(pci->dev, ret,
> >> +                                             "Failed to set opp: freq %ld\n",
> >> +                                             dev_pm_opp_get_freq(opp));
> >> +                       dev_pm_opp_put(opp);
> >> +               }
> >> +               pcie->opp_supported = true;
> >> +       }
> >> +
> >> +       /* Skip icc init if opp is supported as icc bw vote is handled by opp framework */
> >> +       if (!pcie->opp_supported) {
> >> +               ret = qcom_pcie_icc_init(pcie);
> >> +               if (ret)
> >> +                       goto err_pm_runtime_put;
> >> +       }
> >>
> >>          ret = pcie->cfg->ops->get_resources(pcie);
> >>          if (ret)
> >> @@ -1561,7 +1618,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >>                  goto err_phy_exit;
> >>          }
> >>
> >> -       qcom_pcie_icc_update(pcie);
> >> +       qcom_pcie_icc_opp_update(pcie);
> >>
> >>          if (pcie->mhi)
> >>                  qcom_pcie_init_debugfs(pcie);
> >> @@ -1640,7 +1697,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
> >>                  pcie->suspended = false;
> >>          }
> >>
> >> -       qcom_pcie_icc_update(pcie);
> >> +       qcom_pcie_icc_opp_update(pcie);
> >>
> >>          return 0;
> >>   }
> >>
> >> --
> >> 2.42.0
> >>
> >>
> >
> >



-- 
With best wishes
Dmitry

