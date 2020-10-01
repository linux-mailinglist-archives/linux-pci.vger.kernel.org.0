Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4516280428
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 18:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbgJAQnZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 12:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732048AbgJAQnY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 12:43:24 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 411C820872
        for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2020 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601570604;
        bh=SIpvCZFXKcvaiBU6NzzakefG/CNTAk+7hLKD2w8YR2M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1jffn/wRSvGGismn1GMelvK2OR0wijVpxFWoBJhQj31kOTIP251Zlh2UiGVipHb4S
         nIvHJJi3GIA+wgcbaA01Ng0vjtjai0eW9eoXqx0JO5BP7YvxhDlX3bMN15aV1lfCD2
         cC6OlzRnXg9xuvnk01k6BUNtZzP4X4PsgHVxqU8w=
Received: by mail-ot1-f47.google.com with SMTP id s66so6105994otb.2
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2020 09:43:24 -0700 (PDT)
X-Gm-Message-State: AOAM531TkEuDi0RzOddjjT5CbJaVmPxBNo9bIQPso4ZdUZLjUx+UG7tu
        M37If5eQca/lQ8kYLFHA7y5cQNZ1WEZuTVxIGw==
X-Google-Smtp-Source: ABdhPJwFsUawNcgTRWCrPpRv6adaO+bAzC3+3/EYnwxKRgJwZRp4LojLVnAkLyA1cukH4NF2EMh2ARpbHCTlzB9/azY=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr5611707otp.129.1601570603632;
 Thu, 01 Oct 2020 09:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqKhP+o_Y6t8HRRp20F3isAtqdNLPzhg7VxDyY7j-UYOSA@mail.gmail.com>
 <20201001155310.GA2691450@bjorn-Precision-5520>
In-Reply-To: <20201001155310.GA2691450@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 1 Oct 2020 11:43:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKKhN26qJT50zwaqtFDeUJBPJk0bRrGnFAz4k9K6f_Lhw@mail.gmail.com>
Message-ID: <CAL_JsqKKhN26qJT50zwaqtFDeUJBPJk0bRrGnFAz4k9K6f_Lhw@mail.gmail.com>
Subject: Re: of_match[] warnings
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pratyush Anand <pratyush.anand@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 1, 2020 at 10:53 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Oct 01, 2020 at 07:48:23AM -0500, Rob Herring wrote:
> > On Wed, Sep 30, 2020 at 5:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > These warnings are sort of annoying.  I guess most of the other
> > > drivers avoid this by depending on OF as well as COMPILE_TEST.
> >
> > Using the of_match_ptr() macro should prevent this.
>
> Both drivers *do* use of_match_ptr(), but the of_device_id table is
> unused when of_match_ptr() throws away the pointer.

Oh right, it's actually we don't want to use of_match_ptr() in this case.

> I guess we could add __maybe_unused to squelch the warning.  Ugly, but
> I do think COMPILE_TEST has some value.

We do that or an ifdef for drivers that actually work for !OF.

We also have lot's of 'depends on OF' as proposed too, but that's not
really my preference given we have empty functions for most
everything.

Rob
