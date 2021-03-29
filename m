Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35BD34D545
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhC2QkI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhC2QkD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 12:40:03 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EFBC061574;
        Mon, 29 Mar 2021 09:40:03 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so12855389ota.9;
        Mon, 29 Mar 2021 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ex63vWwUbIdu6VJIUmFF3Jq7NwLkwAySz2ZYeVaAkB0=;
        b=lSOD1C4LFH7ve9KSviGKDsdq6aXZeyeWfbLp3IOToARXWnQc6b2iI75JFwIdDgtM7Z
         6Dz/JAURie535hxsMevqCDpCx8jgaYmzZygXrSsTwmmRauaCvWQZl5EO/RnAX9JMRRuP
         E6/0qqnpC5ZS0HMquWCeeNHkOY3OPytfv0nbJFqi/f3xxLYITms1LvSdHLcWgTdaLQ4t
         lGv1yc5oMbgAExnexTLYp+1FHfsWy/IVC8YE+L0yPTFLZmww5h1qQN7h00yOprwCnyKB
         ZhikgD/ZcihWc01V7SfF4kijhQ88XOK4TU0+wGTTRRoX8LU8Q65FtWMrCnTissFwLRGI
         K/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ex63vWwUbIdu6VJIUmFF3Jq7NwLkwAySz2ZYeVaAkB0=;
        b=KhjgB9V+otVfDTg/jbybkOKftPn1+DCNw8dLn1WzuWI2d1uK8w7hlmpSEobz9OlGqu
         VjiCqx6xiEtlFwJM3cOidqpkGt0qsfW2ndl02SLR/TJ2cvJUNgOVJhGz3UlS2N/LhOlC
         EH6hGHJmZrq+gdeVSYhydWAa6gO6cfa+7oPsOiPd5p7E0Ew/9RMvDHFP0BMDZbh7eBxK
         QYh9dGHMv8uSG0Xm6bRnqpjvQY2DXu+YLrOyDxatamArUS2ln1lv880Wvxv9ReUOF4IM
         nIpQhgWfzE4eL8JYWXxRPoCj7EFdpb2THWghFpZyTSjxk8vquo7aGNcQ7T2AvOCaWsta
         6sIA==
X-Gm-Message-State: AOAM533de0Mq27p1fiF2LcFkBip3M7QwMEpOOua3PmjygQS6AizbgHJg
        bGYk7wWe9V/xXyaxJtKkXEszLwHXU6slURYYHmo=
X-Google-Smtp-Source: ABdhPJyI05uRfuRARZh3HGs7S0x5QEIgxG0cQA4C0WP+P6DLKjd/tyeQ5N0CV29DM42tjxh2eGHgZLKoPfKZNjPss2Y=
X-Received: by 2002:a05:6830:14a:: with SMTP id j10mr24055840otp.143.1617036002569;
 Mon, 29 Mar 2021 09:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210326191906.43567-1-jim2101024@gmail.com> <20210326191906.43567-3-jim2101024@gmail.com>
 <20210329162539.GG5166@sirena.org.uk>
In-Reply-To: <20210329162539.GG5166@sirena.org.uk>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Mon, 29 Mar 2021 12:39:50 -0400
Message-ID: <CANCKTBsBNhwG8VQQAQfAfw9jaWLkT+yYJ0oG-HBhA9xiO+jLvA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] PCI: brcmstb: Add control of EP voltage regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 29, 2021 at 12:25 PM Mark Brown <broonie@kernel.org>
w./lib/python3.6/site-packages/dtschema/schemasrote:
>
> On Fri, Mar 26, 2021 at 03:19:00PM -0400, Jim Quinlan wrote:
>
> > +             /* Now look for regulator supply properties */
> > +             for_each_property_of_node(child, pp) {
> > +                     int i, n = strnlen(pp->name, max_name_len);
> > +
> > +                     if (n <= 7 || strncmp("-supply", &pp->name[n - 7], 7))
> > +                             continue;
>
> Here you are figuring out a device local supply name...
>
> > +     /*
> > +      * Get the regulators that the EP devianswerces require.  We cannot use
> > +      * pcie->dev as the device argument in regulator_bulk_get() since
> > +      * it will not find the regulators.  Instead, use NULL and the
> > +      * regulators are looked up by their name.
> > +      */
> > +     return regulator_bulk_get(NULL, pcie->num_supplies, pcie->supplies);
>
> ...and here you are trying to look up that device local name in the
> global namespace.  That's not going to work well, the global names that
> supplies are labelled with may be completely different to what the chip
> designer called them and there could easily be naming collisions between
> different chips.

Hello Mark,
I am re-submitting this pullreq using
"devm_regulator_bulk_get(pcie->dev, ...)"; is your concern about the
NULL for the device and if so does this fix it?  If not, what do you
suggest that I do?
Thanks,
Jim
