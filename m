Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC40315028
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 14:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhBIN2c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 08:28:32 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39127 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhBIN2b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2021 08:28:31 -0500
Received: by mail-wm1-f41.google.com with SMTP id u14so3434143wmq.4
        for <linux-pci@vger.kernel.org>; Tue, 09 Feb 2021 05:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J4N9PdQUM0nd2PZV0vENrn3x6gqL12UYGYhePuC1txI=;
        b=Zii+IBY7KkOPeuM+noEflwbUnKNKD9xVFw/3hOjbMX1Z/ChR3rVnVQKKCSLO0Sz8d/
         1Yh2zhxKh2ejELL3kUyX+A37YRQjf3+HNalrDwu2l9QYsmFS9tQzCPIPwZTJu8wPll3V
         5zz90Eg4Kk59X3njeqWq79oWS1mSDFflpsElP7DQ3fX9dMMolK3fOt3Buka2qv2AK9od
         7b8zXdgCgv1MHxxlDrHzqWNjgRDj8+6BXoeoCsQdhkgnXGFv2qq8tmdLam4j23nIWtt7
         CAqYSqWTp0GM/YIV85I9L30V4pvMPK9H4V7LJUWPywuXSvqfgKUOF8KpPI6lQoQBsQHd
         lzxA==
X-Gm-Message-State: AOAM531Ku+p5CrUS8SevDKWNlkcoXQ4CN1LKAusELhhB8p7BGGh/8Qrh
        0PPNeyAt3h8z0J1lPZuFpRs=
X-Google-Smtp-Source: ABdhPJzmaNutTQeva6T994UrEJpuWUxFhZg74xox+EX9bNItLVitShnODWo0Y3jtLzigALgLv1ATYg==
X-Received: by 2002:a1c:9cc5:: with SMTP id f188mr3353392wme.171.1612877269427;
        Tue, 09 Feb 2021 05:27:49 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j7sm38636522wrp.72.2021.02.09.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:27:48 -0800 (PST)
Date:   Tue, 9 Feb 2021 14:27:47 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        prime.zeng@huawei.com, linuxarm@openeuler.org
Subject: Re: [PATCH] PCI: Use subdir-ccflags-* to inherit debug flag
Message-ID: <YCKN0+wsH/W2lZ+Q@rocinante>
References: <1612438215-33105-1-git-send-email-yangyicong@hisilicon.com>
 <YBvoauS9WagVizdh@rocinante>
 <3171ed82-c114-2298-1c03-f7c854fb15c0@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3171ed82-c114-2298-1c03-f7c854fb15c0@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yicong,

[...]
> > By the way, did you have some issues with things like pr_debug() and other
> > things printing debug information not working correctly before?
> 
> i cannot remember that i have met any, so maybe they work properly. :)
[...]

That's good to know!  I suspect, some of the pr_debug() invocations
might not be working correctly at the moment, so this is a nice
improvement.

Having said that, if you have some time, can you update the patch
against the PCI tree with the commit message from this thread?

  https://lore.kernel.org/lkml/1612868899-9185-1-git-send-email-yangyicong@hisilicon.com/

The commit messages there for the individual patches are much nicer, so
if you don't mind, it would be nice have the same one in the PCI tree.

My review still applies.

Thank you again for sending the patch over!

Krzysztof
