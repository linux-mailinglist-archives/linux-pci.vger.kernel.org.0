Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7DD4811E9
	for <lists+linux-pci@lfdr.de>; Wed, 29 Dec 2021 12:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbhL2LMu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 06:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbhL2LMt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 06:12:49 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57743C061574
        for <linux-pci@vger.kernel.org>; Wed, 29 Dec 2021 03:12:49 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id ke6so18921797qvb.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Dec 2021 03:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MK+wv3Q9ielT8iXy8qRJPd+VCDkiwmXUWkCOO3KJKF0=;
        b=trfeqc9D6qWnrrEa9clqEmsiT9mj3yY5MpLpvwvGKYl0byXxi5fjbNQf77oUFPD4nX
         37oHLE4uVDzPkg+QYTQBKtFkGObyFfSxN2vhDK/tl8LgZ5Qo8uXj7OjFQ9WHk8trIvTz
         vAUZ/Qvb2Ri4cb43IzFnZr2oQHVDGZ66ElPJtAHF8kckpAgEn9lCYWAiym2Eff7Mx9ZT
         xH20GaE11w2JFvJcF6VK3SJYEUEctUrf/MnypX2S55Iyiy3pyjmJSdK+3odtC1zb0I0a
         njN9nj8cPcy6qdOUq/NSbL0GMTjkTTK0pATUfKCeDnTXI7FEmipw/08SRtgsWLts9VHn
         TWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MK+wv3Q9ielT8iXy8qRJPd+VCDkiwmXUWkCOO3KJKF0=;
        b=239iT/+wkQqq1S9xjKyfoMS4eFvy8bJbuAoQKbqAJMeUIFVXdVrmX7azd7VfJBa/Qe
         VTfsrFGPj+V/ZjrLcwl1haSDvnPqjH/lR747j9FT0HzS+DMtV7HaERfPqKNLRXGd4i9q
         8ydHHzO4y7cWJjfFk3Ae0Y3Wf6E9pYIxbOn/5KG3mUCN7pZbHn1oQgdPVbBqHFj/Bpro
         Sb7K7z7AW9zwOAD5ntJSRFV43GEIJWL0nowE6wk1BEtZOau3rJ2oVKX5WHI8nfPK1Chi
         5bmtZSruiEruZqZrrfAXoan9mwkVx2hoTEk4615JXEKvKnMumTrbmYJX0Zoz5nJKZxYy
         6Cxw==
X-Gm-Message-State: AOAM532dT8T0zgbQtpaMso9E/rfLp2aqVByRgklOhBBzgzdZacpJuWqU
        Ic/VgO2aXdvySB26Yj7XBe3ECMBR1JUT3evs34lkDw==
X-Google-Smtp-Source: ABdhPJx/ycB9hnFgWIFMr485YIetQ5jMQIZjyS0fs06KaM88EI1mr4pBAJAI0mNqkQn08i9geel87TfDRgxCxnTz+sE=
X-Received: by 2002:a05:6214:226e:: with SMTP id gs14mr23861400qvb.119.1640776368524;
 Wed, 29 Dec 2021 03:12:48 -0800 (PST)
MIME-Version: 1.0
References: <1640189262-9699-1-git-send-email-quic_c_pmaliset@quicinc.com>
 <CAA8EJpoq1xPj3nkZfjjviCQdLq-LcMVThTK6HzrW7AdmfebuhA@mail.gmail.com> <CO1PR02MB85374269B7CA824BA4AC27ACE9449@CO1PR02MB8537.namprd02.prod.outlook.com>
In-Reply-To: <CO1PR02MB85374269B7CA824BA4AC27ACE9449@CO1PR02MB8537.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 29 Dec 2021 14:12:37 +0300
Message-ID: <CAA8EJpqb_40+8OXuOUeG4iGDiK3-DSAPTjqrbVRecAQCdThKbQ@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: qcom: Add system PM support
To:     "Prasad Malisetty (Temp)" <pmaliset@qti.qualcomm.com>
Cc:     Prasad Malisetty <quic_c_pmaliset@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        quic_vbadigan <quic_vbadigan@quicinc.com>,
        "Rama Krishna (QUIC)" <quic_ramkri@quicinc.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        quic_pmaliset <quic_pmaliset@quicinc.com>,
        quic_skananth <quic_skananth@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prasad,

On Wed, 29 Dec 2021 at 13:59, Prasad Malisetty (Temp)
<pmaliset@qti.qualcomm.com> wrote:
>
> Hi Dmitry,
>
> Thanks for the review and comments.
>
> Please find the response inline.

Could you please use proper quoting nesting, it's hard to read if your
answers are marked as level 2 quote (>>).

>
> Thanks
> -Prasad
>
> -----Original Message-----
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Sent: Thursday, December 23, 2021 8:44 PM
> To: Prasad Malisetty <quic_c_pmaliset@quicinc.com>
> Cc: agross@kernel.org; bjorn.andersson@linaro.org; lorenzo.pieralisi@arm.=
com; robh@kernel.org; kw@linux.com; bhelgaas@google.com; linux-pci@vger.ker=
nel.org; linux-arm-msm@vger.kernel.org; linux-kernel@vger.kernel.org; quic_=
vbadigan <quic_vbadigan@quicinc.com>; Rama Krishna (QUIC) <quic_ramkri@quic=
inc.com>; manivannan.sadhasivam@linaro.org; swboyd@chromium.org; quic_pmali=
set <quic_pmaliset@quicinc.com>
> Subject: Re: [PATCH v1] PCI: qcom: Add system PM support
>
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f any links or attachments, and do not enable macros.
>
> On Wed, 22 Dec 2021 at 19:08, Prasad Malisetty <quic_c_pmaliset@quicinc.c=
om> wrote:
> >
> > From: Prasad Malisetty <quic_pmaliset@quicinc.com>
> >
> > Add suspend_noirq and resume_noirq callbacks to handle System suspend
> > and resume in dwc pcie controller driver.
> >
> > When system suspends, send PME turnoff message to enter link into L2
> > state. Along with powerdown the PHY, disable pipe clock, switch
> > gcc_pcie_1_pipe_clk_src to XO if mux is supported and disable the pcie
> > clocks, regulators.
>
> The GDSC stays on, if I'm not mistaken. Is this an expected behaviour for=
 the suspend procedure?
>
> >> No, GDSC will be disabled as part of system suspend. We are switching =
gcc_pcie_1_clk_src to XO as GDSC should be enable in resume path.

I think you should call the pm_runtime_suspend() kind of function to
let the Linux core power down the GDSC power domains.

>
> Also as a side note, the qcom-pcie driver supports a variety of SoCs from=
 different generations. Which platforms were really tested?
> Judging from your patch I suppose that you did not test this on any non-r=
ecent platform.
>
> >> We have tested on SC7280 SoC which is recently added.

Please take care and check that your code doesn't break previous
generations. You are using structures specific to 2.7.0 from the
generic code path. This is not legit.

>
> > When system resumes, PCIe link will be re-established and setup rc
> > settings.
> >
> > Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 103
> > +++++++++++++++++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> > b/drivers/pci/controller/dwc/pcie-qcom.c
> > index c19cd506..24dcf5a 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -73,6 +73,8 @@
> >
> >  #define PCIE20_PARF_Q2A_FLUSH                  0x1AC
> >
> > +#define PCIE20_PARF_PM_STTS                     0x24
> > +
> >  #define PCIE20_MISC_CONTROL_1_REG              0x8BC
> >  #define DBI_RO_WR_EN                           1
> >
> > @@ -1616,6 +1618,107 @@ static int qcom_pcie_probe(struct platform_devi=
ce *pdev)
> >         return ret;
> >  }
> >
> > +static int qcom_pcie_send_pme_turnoff_msg(struct qcom_pcie *pcie) {
> > +       int ret =3D 0;
> > +       u32 val =3D 0, poll_val =3D 0;
> > +       uint64_t l23_rdy_poll_timeout =3D 100000;
> > +       struct dw_pcie *pci =3D pcie->pci;
> > +       struct device *dev =3D pci->dev;
> > +
> > +       val =3D readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> > +       val |=3D BIT(4);
> > +       writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> > +
> > +       ret =3D readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), =
poll_val,
> > +                       (poll_val & BIT(5)), 10000, l23_rdy_poll_timeou=
t);
> > +       if (!ret)
> > +               dev_dbg(dev, "PCIe: PM_Enter_L23 is received\n");
> > +       else
> > +               dev_err(dev, "PM_Enter_L23 is NOT received.PARF_PM_STTS=
 0x%x\n",
> > +                       readl_relaxed(pcie->parf +
> > + PCIE20_PARF_PM_STTS));
> > +
> > +       return ret;
> > +}
> > +
> > +static void qcom_pcie_host_disable(struct qcom_pcie *pcie) {
> > +       struct qcom_pcie_resources_2_7_0 *res =3D &pcie->res.v2_7_0;
> > +
> > +       /*Assert the reset of endpoint */
> > +       qcom_ep_reset_assert(pcie);
> > +
> > +       /* Put PHY into POWER DOWN state */
> > +       phy_power_off(pcie->phy);
> > +
> > +       writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > +
> > +       /* Disable pipe clock */
> > +       pcie->ops->post_deinit(pcie);
> > +
> > +       /* Change GCC_PCIE_1_PIPE_MUXR register to 0x2 for XO as parent=
 */
> > +       if (pcie->pipe_clk_need_muxing)
> > +               clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> > +
> > +       /* Disable PCIe clocks and regulators*/
> > +       pcie->ops->deinit(pcie);
> > +}
> > +
> > +static int __maybe_unused qcom_pcie_pm_suspend_noirq(struct device
> > +*dev) {
> > +       int ret =3D 0;
> > +       struct qcom_pcie *pcie =3D dev_get_drvdata(dev);
> > +       struct dw_pcie *pci =3D pcie->pci;
> > +
> > +       if (!dw_pcie_link_up(pci)) {
> > +               dev_err(dev, "Power has been turned off already\n");
> > +               return ret;
> > +       }
> > +
> > +       /* Send PME turnoff msg */
> > +       ret =3D qcom_pcie_send_pme_turnoff_msg(pcie);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Power down the PHY, disable clock and regulators */
> > +       qcom_pcie_host_disable(pcie);
> > +
> > +       dev_info(dev, "PM: PCI is suspended\n");
> > +       return ret;
> > +}
> > +
> > +/* Resume the PCIe link */
> > +static int __maybe_unused qcom_pcie_pm_resume_noirq(struct device
> > +*dev) {
> > +       int ret =3D 0;
> > +       struct qcom_pcie *pcie =3D dev_get_drvdata(dev);
> > +       struct dw_pcie *pci =3D pcie->pci;
> > +       struct pcie_port *pp =3D &pci->pp;
> > +
> > +       dev_info(dev, "PM: Resuming\n");
> > +
> > +       /* Initialize PCIe host */
> > +       ret =3D qcom_pcie_host_init(pp);
> > +       if (ret)
> > +               dev_err(dev, "cannot initialize host\n");
> > +
> > +       dw_pcie_iatu_detect(pci);
> > +       dw_pcie_setup_rc(pp);
> > +
> > +       /* Start the PCIe link */
> > +       qcom_pcie_start_link(pci);
> > +
> > +       ret =3D dw_pcie_wait_for_link(pci);
> > +       if (ret)
> > +               dev_err(dev, "Link never came up, Resume failed\n");
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct dev_pm_ops qcom_pcie_pm_ops =3D {
> > +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_pm_suspend_noirq,
> > +qcom_pcie_pm_resume_noirq) };
> > +
> >  static const struct of_device_id qcom_pcie_match[] =3D {
> >         { .compatible =3D "qcom,pcie-apq8084", .data =3D &apq8084_cfg }=
,
> >         { .compatible =3D "qcom,pcie-ipq8064", .data =3D &ipq8064_cfg }=
,
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> > member of Code Aurora Forum, hosted by The Linux Foundation
> >
>
>
> --
> With best wishes
> Dmitry



--=20
With best wishes
Dmitry
