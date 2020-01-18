Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA3B14152D
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2020 01:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgARA2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 19:28:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43083 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729795AbgARA2R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2020 19:28:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id 9so19689417lfq.10
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2020 16:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGezdQEF2oN9RzY7rtgG+ABo1URCw4cTByw+RslsSBA=;
        b=I5T13goFYmuvhic8IOyx+Eb2v01MCLImHwdW7Ks0bHFKt9Di/V7VBYl6PqBlFnN+O3
         k/4bL+RYk7BLwDufMAmexCv3gtA1SBAk3GKfwKIAjTWjmTMjqT7c4vSIk+2kyduqUyEg
         Tw1t5BQMq15a81gICP43jCw4lSqrKTJsQPvr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGezdQEF2oN9RzY7rtgG+ABo1URCw4cTByw+RslsSBA=;
        b=gi0gWUo/JPJMYtcLDpi/V8bVKPn0jxsZ1xYx4eF2cJWhW8WKYiRUKgVEvis4mKcj7Z
         4m2b+IBm0BuVShIH9MIJyV39n2gJhVposN1uz7uS6MOZduGclOLcC7cWIXsjQECnrmvb
         lyrWM3fKieQVEqx17Nb0A6mxLRRgODjsrnZOjPEKJjokt0t/1J0NizPSWVXFcGvgPwk0
         DY41T1gKmyPMFhpcG7coa8Bw4FQ0a4fVnZ7z7pWtSl6OoFeFLT0aQApHgNw56s6oGJiP
         ohh8XjiMYQiLa7ynOTPctgkxhuEJVzbyq+U1LPn4T4Vk4q8+sJaj0/2gN/hGrxT9+DG4
         J/Bw==
X-Gm-Message-State: APjAAAWyfE/yyPpKQbz8Q1DxNTUowAoCtErS/syruBmJzwn141AgaM24
        kxy5QFMX4hKkG0RxVukM2ABNcgSSqQU=
X-Google-Smtp-Source: APXvYqzmJVVncw03RP7J6BQCKUIbSpKQoh1H3cDIv9Mec5fXLt8Sl6kPYiPS474wv562TZuK46h99A==
X-Received: by 2002:ac2:5605:: with SMTP id v5mr6782810lfd.136.1579307294983;
        Fri, 17 Jan 2020 16:28:14 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id z5sm13068736lji.40.2020.01.17.16.28.14
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 16:28:14 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id j26so28189645ljc.12
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2020 16:28:14 -0800 (PST)
X-Received: by 2002:a2e:b054:: with SMTP id d20mr6953708ljl.190.1579307293688;
 Fri, 17 Jan 2020 16:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
In-Reply-To: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 17 Jan 2020 16:27:37 -0800
X-Gmail-Original-Message-ID: <CAE=gft7mM-YUmuL=opwgJYy_o4=bhb=iO7_SWQWahhbJ8z=95A@mail.gmail.com>
Message-ID: <CAE=gft7mM-YUmuL=opwgJYy_o4=bhb=iO7_SWQWahhbJ8z=95A@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 16, 2020 at 1:31 PM Evan Green <evgreen@chromium.org> wrote:
>
> __pci_write_msi_msg() updates three registers in the device: address
> high, address low, and data. On x86 systems, address low contains
> CPU targeting info, and data contains the vector. The order of writes
> is address, then data.
>
> This is problematic if an interrupt comes in after address has
> been written, but before data is updated, and the SMP affinity of
> the interrupt is changing. In this case, the interrupt targets the
> wrong vector on the new CPU.
>
> This case is pretty easy to stumble into using xhci and CPU hotplugging.
> Create a script that targets interrupts at a set of cores and then
> offlines those cores. Put some stress on USB, and then watch xhci lose
> an interrupt and die.
>
> Avoid this by disabling MSIs during the update.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>

Note to reviewers: I posted a v2 of this patch with some improvements here:
https://lore.kernel.org/lkml/20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid/T/#u
