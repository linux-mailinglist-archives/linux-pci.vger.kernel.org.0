Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE141DC856
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 10:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgEUIQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 04:16:42 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:34528 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgEUIQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 04:16:41 -0400
Received: by mail-ej1-f66.google.com with SMTP id j21so7796579ejy.1
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 01:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFsG+y77FcIxwm4f/pZxtzVsUGGqdtpPPsULnBUSG4E=;
        b=BpDfk3t6wJSZjEfWFcuMW9QSfmLUMtJ+K67UKEwXFOmxQzv6DocB7eSBWwpvGt0Rox
         ROa1uqrYmjwjyLJfLp8pSddiIkSzvvKfPfOgTDEwTx5Hfa72vXS2Pf0MtiqAZGxJAIgk
         TWnNyJqou3HXYiFxDo1ilEApioh6q0PLu1lQrFI4cbQM+pn38K6FZ27Qgh4UyQJkw41J
         Wxsd7upyi+UizinrEt2yR1jRt1Pw+pVt43uHElcc78jgpDkSfZ3i2Lx1KN9ns5KOP7gl
         9+bdR4PUCeptijbr24iJ2OZ56Y1bxUTc2JtfD7lXLI4msnAKcHPmmWR6hrA8RMuJ1/Dr
         r+og==
X-Gm-Message-State: AOAM532ZkQwjj82hqb0LvR8VSM/ktK664rMVWw/cwZRu6fEWgfKZC8w/
        1roaZRpuwhHTGy0YtL6aWDI=
X-Google-Smtp-Source: ABdhPJxlt8KmRpqUqgfTHJcVTbXYWofOCasRkQUH5bNJTZKS5nZxuTolw3Zj78xbbma6t0Q7mThQpg==
X-Received: by 2002:a17:906:7fd7:: with SMTP id r23mr2367681ejs.386.1590049000220;
        Thu, 21 May 2020 01:16:40 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id gf25sm4123845ejb.54.2020.05.21.01.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 01:16:39 -0700 (PDT)
Date:   Thu, 21 May 2020 10:16:38 +0200
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: Reference bridge window resources explicitly
Message-ID: <20200521081638.GA30231@rocinante>
References: <20200520183411.1534621-1-kw@linux.com>
 <20200520203022.GA1117009@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520203022.GA1117009@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-05-20 15:30:22, Bjorn Helgaas wrote:

Hello Bjorn!

[...]
> 
> Applied to pci/enumeration for v5.8, thanks!

Thank you for help!

Sadly, I need to send v4 after getting a message from the kbuild bot, as
there was a variable I missed when authoring diff for v3.  Sorry about
that!

Krzysztof
