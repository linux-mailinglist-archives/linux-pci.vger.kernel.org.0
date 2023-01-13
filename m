Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9064B669E73
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjAMQnt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjAMQnO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:43:14 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705E63D0A;
        Fri, 13 Jan 2023 08:41:43 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q23-20020a17090a065700b002290913a521so5282477pje.5;
        Fri, 13 Jan 2023 08:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I15FjO3opbKLh+yZJX3adWH5TdeQq1TbMxByvnF2l8s=;
        b=fBDi5XKaeCpcq/se1lAYYQ/u6S7Yg3+zGYacUGmEYlyRbWdMvYykl0H+wjo6wF+eyx
         HyDaGQ8M/WV/LGEzQBEDJ4CjvMnXw+94relc2qx4lMqLbO4SN1ouWf/rpctG70IIyznO
         mkv33RE0d44R5G9o9iqDhQgJpIjfLVzoPfUIjcXBGpNWc9B1g89mEYcJhYX9AiPk1t0o
         5+YkQ8SFuB8vXIQ9O1+7yP3Tsk3gb67Yy9a818C9KxYHSdcwbMJ5eQlzG6IST16mIJmr
         mGpMV9PnyVbEZ6Js6Z6B5UMo3Es9CgRIvYBSAlqKLzSGCm+dY7KrOw+E2BggVgl9srXc
         aJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I15FjO3opbKLh+yZJX3adWH5TdeQq1TbMxByvnF2l8s=;
        b=eRALzvL2FSyjv04WOs3UcPkCIVacrIeDREtJ1ecVsUIFb5svL1TvUk7hOyyeGG6xR9
         W5/GEEui6EYQkF56GW1dD/X2BvDr/jkwG9qXFAo8WlfJdVC8qJF+i7AlfKZOLgsu67XI
         baYl2bAknGrQtbrFduZHyhBai2qVLNXZ9NdNpHGWJ/v3YXSQhN7Acs8yH8+LQOZtC/B7
         QcuxERcGN6WHYbKmEjC1Tgypid/7I7A2eIvKdNNAfQKhNTqFsi9+HXmKC6bNKKb3f0eN
         /mXOplwkUQD0zEfo76YOfcoLngF+WLDTkJYeY1xcEG9DDEBzy5fFJxyrAsNaV4K0/9ow
         Oe/w==
X-Gm-Message-State: AFqh2kpaL+3T9lfnjIRD7vV7YQ81sLlnhABGBWdZLfDSg5C72OlvQzF6
        hLcLd1+gXlio2u2dKdpaCSU6IWXIp0marbH6Q0Y=
X-Google-Smtp-Source: AMrXdXt0grFmAVAEYwlDj2s3RMzBjbg5Qh411PWc5GYUnj7eSetps2OPKVpFH9FXEDorQjCnH0jqjNVaPtKUtXe5rDE=
X-Received: by 2002:a17:90a:bf0a:b0:229:2927:ee16 with SMTP id
 c10-20020a17090abf0a00b002292927ee16mr195721pjs.7.1673628102498; Fri, 13 Jan
 2023 08:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20221116214841.1116735-7-robimarko@gmail.com> <20221117192837.GA1203269@bhelgaas>
 <Y8FdxtCitnBd1c6k@lpieralisi>
In-Reply-To: <Y8FdxtCitnBd1c6k@lpieralisi>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 13 Jan 2023 17:41:31 +0100
Message-ID: <CAOX2RU5HznDP9KcjyO=6MjhrY-cU8dhYiskCiTzLD6jm-pNeRw@mail.gmail.com>
Subject: Re: [PATCH 7/9] PCI: qcom: add support for IPQ8074 Gen3 port
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org, kw@linux.com,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 13 Jan 2023 at 14:34, Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
>
> On Thu, Nov 17, 2022 at 01:28:37PM -0600, Bjorn Helgaas wrote:
> > Hi Robert,
> >
> > If you post a v2 for any reason, capitalize the subject line to match
> > previous history:
> >
> >   PCI: qcom: Rename host-init error label
> >   PCI: qcom: Drop unused post_deinit callback
> >   PCI: qcom: Sort device-id table
> >   PCI: qcom: Clean up IP configurations
> >   ...
>
> If he could do that while rebasing on top of my current pci/qcom branch
> that would be ideal, I tried to cherry-pick patches 5,6,7 but 5 does not
> apply.

Sure, I will send v2 with that now as after cherry-picking the SM8350 commits
from pci/qcom they all still apply, will fixup the subject capitalization.

Regards,
Robert
>
> Thanks,
> Lorenzo
>
> >
> > On Wed, Nov 16, 2022 at 10:48:39PM +0100, Robert Marko wrote:
> > > IPQ8074 has one Gen2 and one Gen3 port, with Gen2 port already supported.
> > > Add compatible for Gen3 port which uses the same controller as IPQ6018.
> > >
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 77e5dc7b88ad..97e8510c53fb 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -1817,6 +1817,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> > >     { .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
> > >     { .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> > >     { .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
> > > +   { .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> > >     { .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
> > >     { .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> > >     { .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> > > --
> > > 2.38.1
> > >
