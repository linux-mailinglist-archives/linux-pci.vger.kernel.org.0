Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB7B2A6BDD
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 18:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgKDRhO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 12:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgKDRhN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 12:37:13 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E9C0613D3;
        Wed,  4 Nov 2020 09:37:12 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id dk16so30321262ejb.12;
        Wed, 04 Nov 2020 09:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1jUCo3qsGMmYf4isHasTOhehT8pNB9XWrj2LM2ACKFU=;
        b=lBZxHWOuzf8o/ZJb1D8C8gGEf/iMab87JUEzptpHqxR9asnBXXaquqcB6M1z2+AocV
         a0ON5FbhPEFNJIQCUOirWtbJl3jQl4y9+SQa6oEmRIE5a2PDa/gSfVTmWYZKeb2oKW8r
         rVaNIuZOCNQy28QgMBFUGTscPb70FLX8Wtu8nAe+qr5Ib+jDA3Ux9K1jOgAmy2gOhGPU
         CGASkDBhQF06XCprNCUJQK/1sJv0VqkZytccCi9DJt78YAaKnv6iKB2XEimQ8C5VoV/G
         0na7LwFwcJT8b2t35nOjEjtZP6ACCHgUznADenUZ1Pq+eEqRw5Fvu9WE5AF/mVlqC+RK
         5Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1jUCo3qsGMmYf4isHasTOhehT8pNB9XWrj2LM2ACKFU=;
        b=gmfKR/Hmq75R1SgHUXwquhGCGlpUrJ+Q7K5liovcVUeLASNsVakAqIAXCN/dw8UKyd
         MIINNyWCunbIqkSS1La/f/zb56YTOnZ83YD1agAJMPQS5yniCtAK1xdzuA7bfOhAcQr5
         daYdYf9f+tAxP6F53JhcTlGS8Dww/FjKdfAkkh6vLxO/xWfIJygA7ZbNkL2Zvk8lgIEm
         sZ2W4FCxoWezCM5psSkQ35seh9esY7DNJUo9e7GBfQ2d9jx8a0QYp5d/TinQlMphYBQm
         BnQtkFQAFKozp/DSe7sWCiuUkAkz9eJWjKx27og5YFJBRfxho26D3rHhYCfx0jaujVHk
         hWvQ==
X-Gm-Message-State: AOAM532Zn8vpvn3zbhsZ18WEAqgG6hDL7gJwrtSkx814C4jf06EYGsCz
        /xMuvoV+dAYcZK54o4UNrFM/6Q4lT0k=
X-Google-Smtp-Source: ABdhPJxj4WRvrnY0lJfYQCokZRcGMpmXBd3gevBfjJegys1C+AC7mtt7lJZx/FlxaVBRHZ0+yUG8Ug==
X-Received: by 2002:a17:906:b294:: with SMTP id q20mr9047175ejz.234.1604511430561;
        Wed, 04 Nov 2020 09:37:10 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a482.dip0.t-ipconnect.de. [217.229.164.130])
        by smtp.gmail.com with ESMTPSA id p4sm1317138ejw.101.2020.11.04.09.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 09:37:09 -0800 (PST)
Subject: Re: [PATCH] ACPI: Remove trailing whitespace
To:     Joe Perches <joe@perches.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201103211259.GA265488@bjorn-Precision-5520>
 <c92703e3-c964-b4a6-e3df-c4c0c28b44c1@gmail.com>
 <6e392d099bd8aaba14223aa770361dbdeeab271b.camel@perches.com>
 <6d888eb0-bfc5-28ff-c62f-9e769f77bc1f@gmail.com>
 <57b77f3a36f56e2ae7ab8fe367865b5412d4e11f.camel@perches.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <0ec60af0-4ff2-a4ab-c904-96b149250f11@gmail.com>
Date:   Wed, 4 Nov 2020 18:37:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <57b77f3a36f56e2ae7ab8fe367865b5412d4e11f.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/4/20 6:12 PM, Joe Perches wrote:

[...]

>> I'm not too sure about the comments, but I can find the time to look
>> over the output and adjust that if that's something you'd want me to do.
> 
> Up to you.  I hardly looked at the output.
> 
> I'd generally prefer to use a single line comment like
> 
> /* AC Adapter Management */
> 
> but I don't know how often that dashed block is used in ACPI.
> 
> grep seems to show the texts are not correctly centered so it seems like
> it was done by hand and not that some automation tool was used to create
> those blocks.
> 
> Maybe a separate patch could be done to change those if desired.
> But not by me.

I'm hesitant to touch those, mostly as you said because they're
subjective (and I don't really see any big issues with them). Seems to
be the prevalent style in the drivers/acpi, although there are other
block-like separator comments at least in drivers/acpi/dock.c.

> As far as I know, acpi was once autogenerated from a common source tree
> and whitespace changes were once frowned on, but maybe that's changed or
> or perhaps that's only for files in drivers/acpi/acpica/.  I don't know.
> 
> https://acpica.org/downloads/linux

Yeah, any changes to drivers/acpi/acpica would have to go through their
repo.

I'll go over the checkpatch output later and prepare a v2 that doesn't
touch the comments, unless anyone has any issues with that.

Regards,
Max
