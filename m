Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1742B4BED
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 17:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbgKPQ7w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 11:59:52 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38314 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbgKPQ7w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 11:59:52 -0500
Received: by mail-oi1-f196.google.com with SMTP id o25so19539596oie.5;
        Mon, 16 Nov 2020 08:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxLvh45K0xrEIjAoRAnHrvX8kyeOtohYELPD4/GcqkM=;
        b=dBm/OKth7J7p5TaNsKBGTVCd8IdqgifUMVkBTSl7hszwWs56elLlrTO3axpyvhUVH7
         ubond7EXlTdE1U6UuNACCz5SMwN+bcTEXEQhOTQYZ8m9HIriqnG/z9KLA2sikKtZMEiY
         GVLtLlCFInq/2yDzaX/5mqJZs1FywjOtr37ZogxS7CJKDCJD2BimaozXeU9Fd7YTvIXv
         PK8QZ6+oYhx1hkVAV0A8inerAzXvswGUc/1jWyhccUTHE0RquheQMZpZSTCRAk2a0WlA
         gMdL/qRyCiOyrWTL3l9skEgNYwRvPSvpVj9zeX6r324LRezhHE2XCZV+QVAtya0ZFrlm
         AvfA==
X-Gm-Message-State: AOAM530xABc++fYAFv71wzLEkJZNBfV9lGLcUpEyT5KXT45e4sCwfTKT
        UZNBBfe9ti6GtNQ4ohOE8vV7v3T8T/yi1nT3v2I=
X-Google-Smtp-Source: ABdhPJwsMNLTMYUL2rVm2s/uMEUxjKtsA7IubLtHZwYEekHYed31+siwhSYwTJOHOxkV0FBgjBtvVJsqGPvbYKqHOmM=
X-Received: by 2002:aca:c4c9:: with SMTP id u192mr275449oif.69.1605545991214;
 Mon, 16 Nov 2020 08:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com> <20201116165159.GE4077@smile.fi.intel.com>
In-Reply-To: <20201116165159.GE4077@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 17:59:40 +0100
Message-ID: <CAJZ5v0hL2Pbus-U6i4nGaf1rwWNq6ZosVL6N2bwDiFw7W8tOEw@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] resource: introduce union(), intersection() API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 5:51 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 03, 2020 at 10:45:03PM +0200, Andy Shevchenko wrote:
> > Some users may want to use resource library to manage their own resources,
> > besides existing users that open code union() and intersection()
> > implementations.
> >
> > Provide a generic API for wider use.
>
> Greg, Rafael, if there is no further comments, can it be applied?

I don't have any. so I can take this series if there are no concerns from Greg.
