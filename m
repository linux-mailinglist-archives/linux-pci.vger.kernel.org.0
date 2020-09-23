Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE0E274F3F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 04:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgIWCtX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 22:49:23 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:60523 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726873AbgIWCtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 22:49:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 742AE12B2;
        Tue, 22 Sep 2020 22:49:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 22:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=mime-version:references:in-reply-to:from
        :date:message-id:subject:to:cc:content-type; s=fm1; bh=HRaAmkRs0
        dCQ9ZoZ9oxJwplIRQkT3KE8sP5m13Unpho=; b=SvFbur9P1C2s4t20I2Kub2dc6
        4brhXV8sRNeOOrTnvYrfAdW0FSv8NwgrYLJsZL7bJFm3bqHz8l+JJzVFqlth2uNL
        riUUjW+4ZvN7koHUNJGB00StOO9ZWJ9tDDJgoonQfHBahyYkapJbAFQYEA8yDioy
        q7X0yygf2tR2nyTXCP1Mc0AMBy/zCnUfD0a0Yh6JTKW3qVRe696ec1jxRcJjwRdJ
        dItWj/GNhNyvX9laHTPQO0ZU1gEUvmiw0CSeCMvyS8sgLoAmAudnoRhhX6tMfODp
        ZROiqr829pMMrq+7xDN2KKpVOmWySyCTBWDlQZRZe6fF55oOjVcIlsdLyYRgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=HRaAmk
        Rs0dCQ9ZoZ9oxJwplIRQkT3KE8sP5m13Unpho=; b=ssXoi1AaSRKeGoatrY9M3A
        Wy48OAy3EeZX6dS3NCZmWsUtCd3Yd6ANzVMbC+Vb2kFe79ON26xjad3juIwg7TeV
        AOOvfDB28Q0f5OQxgBIz2q6tw9+iY0YTx+AKlHgLiU9IDW/Iqv/E8ox+xYxGT20v
        pisikCMOpq2gEj+70UAd7d+BU5RapJ7vyBkwiY+KGPpPzhfGdutL81znulc0Z7yB
        pL0MFeoBwICYXreLJSsNGexlHipGHny5/7PqAKuTgUXMhGMnAWmaNuw31mTFny7J
        gaduUnOsqxRVqFkeZ2076eERKqXt82qgJdzDKi2LkUuNJBTK8g5qCtuIFFSCh7IQ
        ==
X-ME-Sender: <xms:sLdqXy_5joVTTlI5QEBz9cGnTIG9o0qstJYA6Yuvj_S3xoZHFAOZgA>
    <xme:sLdqXytvChPqgoTqLkJRuKX1M50suqtLlDLd0yDo8KN1bo9MnsdQYH5KlojIQ5_c8
    zmSfO9336P-sUjC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeggfhgjhfffkffuvfgtsehttdertddttdejnecuhfhrohhmpefuvggrnhcuggcu
    mfgvlhhlvgihuceoshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
    eqnecuggftrfgrthhtvghrnhepieelhfetgefhvdetkeejieefteffveekgefgheekieeg
    iefhvedtuddtkefhleejnecukfhppedvtdelrdekhedrvdduledrgedunecuvehluhhsth
    gvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:sbdqX4BPVjiKupangu_nbzuylAYuXUmD_80qn_MQ4UA-3-msTnzieA>
    <xmx:sbdqX6dFEBeZQd_nuVdz9zaAlWQGD6LyXw9Pq1BfmIkQNOmGB-vb2w>
    <xmx:sbdqX3N2ubTSyiQBAt9jUD7MnSfgQGa9L6OBhQwEzp3dsKKeMYpsww>
    <xmx:sbdqX2Y8XyWDbxCbzfuw6oBPCmf9JbB5xIufKMgIkvJgaNFp2W-cvw>
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by mail.messagingengine.com (Postfix) with ESMTPA id CEF45328006A;
        Tue, 22 Sep 2020 22:49:20 -0400 (EDT)
Received: by mail-qv1-f41.google.com with SMTP id p15so10623545qvk.5;
        Tue, 22 Sep 2020 19:49:20 -0700 (PDT)
X-Gm-Message-State: AOAM5328Z5OkEv5xeq129YeaMUgHtVlg+xpmqmVbRlcnSSuM+SxcOCZg
        HKCGL6Cqth9lQnO8nK5aopN7Liv5HFvoOLYLEnQ=
X-Google-Smtp-Source: ABdhPJznvcD5cMIvVCOlEcNXwIs7baYFjnBVL3cV/BDPmnoTDkm9kTO3tBdy6UZn8U7fExQDR9st2nCnMfcZiERg+f4=
X-Received: by 2002:a0c:b202:: with SMTP id x2mr9169067qvd.49.1600829360477;
 Tue, 22 Sep 2020 19:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200918204603.62100-1-sean.v.kelley@intel.com>
 <20200918204603.62100-6-sean.v.kelley@intel.com> <20200921121355.00002b77@Huawei.com>
In-Reply-To: <20200921121355.00002b77@Huawei.com>
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
Date:   Tue, 22 Sep 2020 19:49:09 -0700
X-Gmail-Original-Message-ID: <CAAbOPF2+1xajGNuNcs3q2FapcCDRFr78EGRmopB66YuKu2G8_w@mail.gmail.com>
Message-ID: <CAAbOPF2+1xajGNuNcs3q2FapcCDRFr78EGRmopB66YuKu2G8_w@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] PCI/AER: Apply function level reset to RCiEP on
 fatal error
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Sean V Kelley <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 21, 2020 at 4:15 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 18 Sep 2020 13:45:58 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >
> > Attempt to do function level reset for an RCiEP associated with an
> > RCEC device on fatal error.
>
> I'm not sure the description is correct. Looks like it will do
> the reset even if not associated with an RCEC.
> I'd just cut this down to:
>
> "Attempt to do a function level reset for an RCiEP on fatal error."

Agree. Will change.

>
> I'm not 100% sure doing an flr will actually help in most cass if you've
> reported a fatal error, but I suppose it does no harm!
>
> So with description changed.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Will do, thanks.

Sean

>
> >
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > ---
> >  drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
> >  1 file changed, 22 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index e575fa6cee63..5380ecc41506 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -169,6 +169,17 @@ static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct pci_dev *,
> >               cb(bridge, userdata);
> >  }
> >
> > +static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
> > +{
> > +     if (!pcie_has_flr(dev))
> > +             return PCI_ERS_RESULT_NONE;
> > +
> > +     if (pcie_flr(dev))
> > +             return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +     return PCI_ERS_RESULT_RECOVERED;
> > +}
> > +
> >  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >                       pci_channel_state_t state,
> >                       pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
> > @@ -195,15 +206,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >       if (state == pci_channel_io_frozen) {
> >               pci_bridge_walk(bridge, report_frozen_detected, &status);
> >               if (type == PCI_EXP_TYPE_RC_END) {
> > -                     pci_warn(dev, "link reset not possible for RCiEP\n");
> > -                     status = PCI_ERS_RESULT_NONE;
> > -                     goto failed;
> > -             }
> > -
> > -             status = reset_subordinate_devices(bridge);
> > -             if (status != PCI_ERS_RESULT_RECOVERED) {
> > -                     pci_warn(dev, "subordinate device reset failed\n");
> > -                     goto failed;
> > +                     status = flr_on_rciep(dev);
> > +                     if (status != PCI_ERS_RESULT_RECOVERED) {
> > +                             pci_warn(dev, "function level reset failed\n");
> > +                             goto failed;
> > +                     }
> > +             } else {
> > +                     status = reset_subordinate_devices(bridge);
> > +                     if (status != PCI_ERS_RESULT_RECOVERED) {
> > +                             pci_warn(dev, "subordinate device reset failed\n");
> > +                             goto failed;
> > +                     }
> >               }
> >       } else {
> >               pci_bridge_walk(bridge, report_normal_detected, &status);
>
>
