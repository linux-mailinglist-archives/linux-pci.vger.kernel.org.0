Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873EC398AE3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 15:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFBNlm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 09:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhFBNlm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 09:41:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E781C06174A;
        Wed,  2 Jun 2021 06:39:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g18so2226855pfr.2;
        Wed, 02 Jun 2021 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hUOeTXG0YC0TwEopFyW5gRSpVI6Gvqblgn3g9W0kHZk=;
        b=EmJUae+0we23sUDmOib5YTlA29oHh/dT98gHgNXJ3Sry3ZxQvM/KL3/PETYEIKjUHA
         KmNn951ymoMGWIcuq7Ba+LeRzpjX+NnawoSOtRy6T3iIAbNlt5rRJ+iYtKtmJrFjDscI
         2Ybi2S8WjdgIyRkSGylZq9raRYEUudBRt3JzC/JS/hvZasnAZV71JATagbqirUVTDSkT
         j0ES7URAPBKv2MnMuHJXLTNPkyTPDCJF+IURPYHEibpTOlRS4SKY5IptkDw8YVnArYLc
         1X35mTorbHweqsYNp4kqDLjAuqmNwvOVnHtwu7m3+zW5njY4zSHA+HjJr3hJRs8Q34vS
         pvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=hUOeTXG0YC0TwEopFyW5gRSpVI6Gvqblgn3g9W0kHZk=;
        b=aH029ATiANRez4MHLGIa+OnOCctbAQ9ICiHX+HxxqVN6QjblZKJ/S/FDw9Sq/wiATC
         ePITT2v2bbO2YvWytnEGoNg1gP2U2KI5jBSLz1qPvf7SW5uTNEQCsyhRsskA9lM2smSW
         +x5iCTHSFN0AjdFOOcIsFkYFbirpYq3svwkH6nnwHBAdFrr1bdx6x6dBwtap/oqOunkB
         qUrRcs9BEdhiDeT+7nWrVqSTwe8I45Eph5/V6rQUv65KGHENahJr9M/bKp11BVc0sqgw
         FCtI+pM0Qii1sIvUv0IiM5T4rGtR1ilGiKigEqOjHj0slOvFfTHjyS++8N4IL0rRycBL
         19UA==
X-Gm-Message-State: AOAM533bV9lVQLRHaHAUbs2eS6TzlUmSGlKwQfXQW5Xk0UPsvA1xEdN9
        qg770QyFaPdlHxsCyVqRiFQ=
X-Google-Smtp-Source: ABdhPJyvkSbrRKLB4qkSLMGR/0Q7Oe9Yiu1u6KChtgZRBoZRdbOT5d1Q6AKh4w5CLvX0B/o2Jcz5BQ==
X-Received: by 2002:aa7:8194:0:b029:2aa:db3a:4c1d with SMTP id g20-20020aa781940000b02902aadb3a4c1dmr27015368pfi.58.1622641198907;
        Wed, 02 Jun 2021 06:39:58 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id d7sm12590413pga.23.2021.06.02.06.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:39:58 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wqu@suse.com, robin.murphy@arm.com, pgwipeout@gmail.com,
        ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, helgaas@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 0/4] PCI: of: Improvements to handle 64-bit attribute
 for non-prefetchable ranges
References: <20210531221057.3406958-1-punitagrawal@gmail.com>
        <75da0524-7588-4ace-a135-69236f2d1d5e@arm.com>
Date:   Wed, 02 Jun 2021 22:39:56 +0900
In-Reply-To: <75da0524-7588-4ace-a135-69236f2d1d5e@arm.com> (Alexandru
        Elisei's message of "Tue, 1 Jun 2021 13:53:19 +0100")
Message-ID: <87pmx4l70z.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

Alexandru Elisei <alexandru.elisei@arm.com> writes:

> Hi Punit,
>
> On 5/31/21 11:10 PM, Punit Agrawal wrote:
>> Hi,
>>
>> Here's an updated version of changes to improve handling of the 64-bit
>> attribute on non-prefetchable host bridge ranges. Previous version can
>> be found at [0].
>>
>> The series addresses Rob and Bjorn's comments on the previous version
>> and updates the checks for 32-bit non-prefetchable window size to only
>> apply to non 64-bit ranges.
>
> Many thanks for the series. I've tested it on my rockpro64, and the NVME works as
> expected:
>
> Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks for taking the patches for a spin.

Punit

[...]

