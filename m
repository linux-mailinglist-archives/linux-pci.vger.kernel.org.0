Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2834111CAE5
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 11:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfLLKdT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 05:33:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfLLKdT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Dec 2019 05:33:19 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F042173E
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2019 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576146798;
        bh=LPJsO6nRqqP9PFe1FLl6uMOPGS5DIg2YqlMaCPg5MAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w0u5g0UzUOl8KmSN0Vk2h+Tl5MOn8iqrYXqfS3FFPR0TUwPpK4Y8jxcwHMjqcpiXH
         983ugN4wR9nZG+gaqSfhdS4XDKekXMtlEdHn8cgdxIWj3OFudei/wVoilvrFpZEtPi
         JKxRHpzmsUR9zoIwOkaCzfZOaCO2zxciUdN36Qmk=
Received: by mail-qt1-f174.google.com with SMTP id z15so1854018qts.5
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2019 02:33:18 -0800 (PST)
X-Gm-Message-State: APjAAAUPJR1sJSL9mz3aVlLd6S4rWwhM+PM8flJ1a1tKCuHj5BJaCDYr
        RWib38LKRWQYh+6qxjTSkJWfpFH2H8/OxoFh2ig=
X-Google-Smtp-Source: APXvYqy6nOfBOXcJE7VRnXXrvhryEyoTK+jymB2zrBL+R3G47BUA4e6cYKHwbgKltFfCUd5b+0vXkmJxsZEppgvGAM4=
X-Received: by 2002:ac8:2afb:: with SMTP id c56mr6943809qta.112.1576146797564;
 Thu, 12 Dec 2019 02:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20191211223438.GA121846@google.com> <afbb14fb-e114-d6de-0bfe-d39be354842e@broadcom.com>
 <CABhMZUU82iRD67yQhpUG3MUx3s9WaZ=tAXA=QriEEjUkNbu22w@mail.gmail.com> <8983ae6c-36ac-7acc-5caa-2d11bf593d44@broadcom.com>
In-Reply-To: <8983ae6c-36ac-7acc-5caa-2d11bf593d44@broadcom.com>
From:   Wei Liu <wei.liu@kernel.org>
Date:   Thu, 12 Dec 2019 10:33:05 +0000
X-Gmail-Original-Message-ID: <CAHd7Wqy=R7LHefrqFgjVirQ4CCfrNY1pwD4LULc5im22RmQ-ZQ@mail.gmail.com>
Message-ID: <CAHd7Wqy=R7LHefrqFgjVirQ4CCfrNY1pwD4LULc5im22RmQ-ZQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: move quirks to driver
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     bjorn@helgaas.com, Bjorn Helgaas <helgaas@kernel.org>,
        Wei Liu <wei.liu@kernel.org>, linux-pci@vger.kernel.org,
        rjui@broadcom.com, Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 12 Dec 2019 at 00:05, Ray Jui <ray.jui@broadcom.com> wrote:
>
>
>
> On 12/11/19 4:02 PM, Bjorn Helgaas wrote:
> > On Wed, Dec 11, 2019 at 5:40 PM Ray Jui <ray.jui@broadcom.com> wrote:
> >>
> >>
> >>
> >> On 12/11/19 2:34 PM, Bjorn Helgaas wrote:
> >>> On Wed, Dec 11, 2019 at 05:45:11PM +0000, Wei Liu wrote:
> >>>> The quirks were originally enclosed by ifdef. That made the quirks not
> >>>> to be applied when respective drivers were compiled as modules.
> >>>>
> >>>> Move the quirks to driver code to fix the issue.
> >>>>
> >>>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> >>>
> >>> This straddles the core and native driver boundary, so I applied it to
> >>> pci/misc for v5.6.  Thanks, I think this is a great solution!  It's
> >>> always nice when we can encapsulate device-specific things in a
> >>> driver.
> >>>
> >>
> >> Opps! I was going to review and comment and you are quick, :)
> >>
> >> I was going to say, I think it's better to keep this quirk in
> >> "pcie-iproc.c" instead of "pcie-iproc-platform.c".
> >>
> >> The quirk is specific to certain PCIe devices under iProc (activated
> >> based on device ID), but should not be tied to a specific bus
> >> architecture (i.e., platform vs BCMA).
> >
> > I'm happy to move it; that's no problem.
> >
>
> Thanks, Bjorn!

Thank you both.

Wei.
