Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD53469FA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 21:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhCWUiz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 16:38:55 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:43631 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhCWUir (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 16:38:47 -0400
Received: by mail-lf1-f49.google.com with SMTP id m12so28618222lfq.10;
        Tue, 23 Mar 2021 13:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jE/A9gclmbUmROJZXhpIIoLGxsIzSsaypf7ZPzxLMyE=;
        b=sqs/R+w0xoh6hkkdC4A6BnkpHTdlH//5H7vz/sgeHD6+DFg2Snojwpea2E+9k2dTkc
         F75xSVz6E/62yHgVjLjs4yZg/LuIY36P5HYdpljyg+//UOCHih9bTxHMESEiec8Cs/cs
         Z2BVTUMAIpVQcC0cOT8/8TzSHGhgHr/Vr33VdHCzvjo02wo53QhtrZXL4Uu3gjGiML4l
         M+Z2H1iZsbJtRkzyJQn7WDP/ekuCAcEwHL9zP1lZCkUmBqH01VLJD+o6v2hXE5PxBSI/
         rqQtvtBzSnaqcrYjewkGZ64e9FMI9jr1aRxxqskffpQtnQcJrgfIrefY79v/QV+kEhMr
         OohA==
X-Gm-Message-State: AOAM530qvxY+WI1jAFnUlJOZbuvQfYWvwJpL5L2pBwzeGJLz/i9OaUK1
        IZR5yqofNIR8gU7NoeGIojs=
X-Google-Smtp-Source: ABdhPJysYSbfZ3qAIMHLq3hF/G+rSX0ituAGzxZfdmIRZm/VXLyJWx++21gMgpm8ABOLHzc6+H1cUQ==
X-Received: by 2002:a19:e34c:: with SMTP id c12mr3578929lfk.555.1616531925662;
        Tue, 23 Mar 2021 13:38:45 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p18sm15968ljo.75.2021.03.23.13.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:38:45 -0700 (PDT)
Date:   Tue, 23 Mar 2021 21:38:44 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pci: use true and false for bool variable
Message-ID: <YFpR1PrssmxQl01N@rocinante>
References: <1615794000-102771-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1615794000-102771-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for sending the patch over!

> fixed the following coccicheck:
> ./arch/x86/pci/mmconfig-shared.c:464:9-10: WARNING: return of 0/1 in
> function 'is_mmconf_reserved' with return type bool
> ./arch/x86/pci/mmconfig-shared.c:493:5-6: WARNING: return of 0/1 in
> function 'is_mmconf_reserved' with return type bool
> ./arch/x86/pci/mmconfig-shared.c:501:9-10: WARNING: return of 0/1 in
> function 'is_mmconf_reserved' with return type bool
> ./arch/x86/pci/mmconfig-shared.c:522:5-6: WARNING: return of 0/1 in
> function 'is_mmconf_reserved' with return type bool
[...]

Looks good, although a few small nitpicks: you should capitalise the
subject line so that it matches the style used in previous commits, and
the commit message could also be improved in terms of style and also
explaining what and why this patch is fixing the return type (aside of
just addressing report from Cocinelle).

Other than that,

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Thank you!

Krzysztof
