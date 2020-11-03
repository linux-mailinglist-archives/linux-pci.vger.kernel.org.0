Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6492A56C7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 22:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbgKCVbC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 16:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732765AbgKCVa6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 16:30:58 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7ABC0613D1;
        Tue,  3 Nov 2020 13:30:57 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id i19so15524175ejx.9;
        Tue, 03 Nov 2020 13:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sw2bhd4jcneB3g3s5IEtSjSEMGNxHMcx8ThO9lFxrJo=;
        b=AwacBScAQqRQ+W5tRID5qqC4IItvIBe3BDXXYC+0UUKV+v2EDZOosorQjCOG2yESgY
         07Wzl3oZgWF+gXl7UA2GFmAYxhjyJjCQ0oWv4jkupNPM19bgqjHZBykek+/HbuCc3niv
         OzOV6BDTftBQHw+Aw4qGgaUEcTk3oWge2d+lnztIOfNjPf2ScjBi56INKEqXAGCDcAqk
         qqwZ0BhoL1cG/gBBMP+6WcNeKORi26Lnawh03qSMQqKnC8jMKQ7osIEUbZoHTToZbQpG
         2sy2OCbY7rBGU4it0QmOC3G40Scym8Yc5jAN8nW7U2X59VfOpw/uSK570ToNOwG9Sw4K
         BBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sw2bhd4jcneB3g3s5IEtSjSEMGNxHMcx8ThO9lFxrJo=;
        b=XY9lk+V+SHvSbcJeVL5u1U0SgzdSfRzmkTzUAuQufJtbCnUMhRrrbYVWQPMpSyktM8
         mPHuYC+ZW+NbJooaAG27o0BIom9fkCjNFXSKMsy72yd8bNZY5HqUF1hrdx2gjk/T/2Ku
         HJqz69XVp+5RUqsK5mdrp2OBovzjzy7Fcy8n7o4gKDcLlvZ1h1oamXW4z4oUZDUBY/jh
         r7TuVnxKMIRcpIfN9MdUS6S2E70RWOPpEdJVRtPsEIpdwHo21m/K+aKPqgECkrqR/fza
         +DVulQLRUToVW5zt/5gEhnbthVeCR3F/Zqw94GDPEHR/2Tz/N5xFGj7nQTQ/qmRcxgtN
         uVow==
X-Gm-Message-State: AOAM532kSh17Qile+InZ7OleEdvml6yQMf7iCXJP3ZrV7Fjz3xHWvLdh
        pWyxW4TG24YsKVQBjibbOLfOItR1htE=
X-Google-Smtp-Source: ABdhPJyanutoQCesRoYcYVxElfnfQCZtpsToh/E2HUl14qaji0oBopAlwyhm81yB9lsiyAeZcgMCfQ==
X-Received: by 2002:a17:906:9902:: with SMTP id zl2mr8130507ejb.510.1604439056114;
        Tue, 03 Nov 2020 13:30:56 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a4cd.dip0.t-ipconnect.de. [217.229.164.205])
        by smtp.gmail.com with ESMTPSA id y14sm56185edo.69.2020.11.03.13.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 13:30:55 -0800 (PST)
Subject: Re: [PATCH] ACPI: Remove trailing whitespace
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201103211259.GA265488@bjorn-Precision-5520>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <c92703e3-c964-b4a6-e3df-c4c0c28b44c1@gmail.com>
Date:   Tue, 3 Nov 2020 22:30:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201103211259.GA265488@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/3/20 10:12 PM, Bjorn Helgaas wrote:
> On Mon, Nov 02, 2020 at 02:36:41PM +0100, Maximilian Luz wrote:
>> Remove trailing whitespace and fix some whitespace inconsitencies while
>> at it.
> 
> I'm OK with this as long as somebody fixes the
> s/inconsitencies/inconsistencies/

Sorry about that, I can resubmit if necessary.

> above.  I assume you've scanned all of drivers/acpi/ for similar
> issues so they can all be fixed at once.

Yes. I scanned drivers/acpi for trailing whitespaces after I noticed a
couple of them. I did not explicitly scan for other stuff like spaces
where there should be tabs, mostly because I haven't found a quick and
reliable solution for that. I only noticed an inconsistent indentation
when committing, so I fixed that too.

> This is up to Rafael, of course.

Thanks,
Max
