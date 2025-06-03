Return-Path: <linux-pci+bounces-28851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B75BACC4A2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 12:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888AD18854E4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28DC1C32FF;
	Tue,  3 Jun 2025 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNxMv2s+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41A317996
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947729; cv=none; b=OvI76Pp3TFmO14BNuRfr9+zn3TbHFO7O1I6nDuw68d8nC5mwHHkh8GI8ZoNQ5A+BbTeSH+myhuV8VVhShc7DW3NSednuuiSXz6s/elVsLyzJPobS+gCHei0QHelEQ7EF/a8OErVetikqY01PEx+MMD8Dn45Mgu+d2tiG6rK7g7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947729; c=relaxed/simple;
	bh=0/t4VZHHaghPD92lE20B6G38trWGNzHFkAze729VO0U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UfPv4UR32YR/6sGLIXlmllFvxVWOOS4BCkWRhvfIxQSep7LW7swK4Cjrza5SACKl2QrZMWQG94pid/NMeO6V0ZNqwnZ8lBBCUXwp/9c6LmXl1o+83pFKPoYhFAVqOiFIrH4Wre2napEt5Z/6cO3ajhcZGTOCAWlh/IJeSDIegFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dNxMv2s+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450dd065828so26282225e9.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748947726; x=1749552526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cx6O8nTXD/s0DawuWtPSuDjWjpCAIEUB9q4GWgLMpfY=;
        b=dNxMv2s+UeY+HlzD8WCyBdFdM02S2388Eh9QBqgxSmkamwdt+uJ32e/3N+o806can0
         OT7CNCyVehE3Kjqx0j6RosGEGY7QByoOkcrFO262wq8RMOObi/KmuOIkv1Z0TqWKWq+M
         Vjkt+1OXxg7MUHIDUPlX5FUheEE+2fRlVRagOunGNhNRsghsfeio/ZFyF8NtBfqU5b02
         wDSxBh7daq6XdvedjPNal4FgV43gLNdImZViVUwJr22Th9h3KXLMgllzanqGhUFMjdDp
         Qh/oGyntnWjbDwOBPG7DD4aQoz6xbmO1J7zFZonbYjYcYvGH8eUmY0h2p7JqOiUunTSA
         /Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748947726; x=1749552526;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx6O8nTXD/s0DawuWtPSuDjWjpCAIEUB9q4GWgLMpfY=;
        b=gRKLOZYvYDmXICdxxWNLRL4UyQyuGeuI+4rcXlc6Hpw55M1IbroRW5V9bHuiWCrUjY
         eFei6mEF9vaMc3/iESMdeXCOR4Arr9WCH8eNc+Sh2G2qfeIC8RkM2ILw059ZI2ZwTWnF
         rYMY4APDbzRqSp0tloLdMIL5tuz/f192gdD68C7eKx1ekz98sVLIiaIsaKenkR685vLE
         P1oK7WFJWsgFxnUyi+44FUyzFgUk72gP4oS6qAJak5Y6iWNDyyTsNY9kS9cs3JLtcqhz
         BWia4nW4WVFDpSkCBa136J9Xg4QhwlesllTMFnzZApr/yg4jmxNwbTQGzSgT7Vv8zUPL
         W6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqxlGZ6eswCngo+kLqA52k1bU/U3Ei9xzw2aDYxD0aX/ezdOqICxO4sDhVxe6D18AnqXcsV6Thn+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSv3aN29iU99VuUCA3lHFacj0tsRLRjIX77rGoAv2fzLr09ElD
	LrK0UmU8vtNafIWPNVdgjMGUMbBJ0nqvr6G+dixTtzBsweeJj6wQs9TN4EMoVNIS85U=
X-Gm-Gg: ASbGncvP5oNpjemOVEWwe9AfekfolZRHe2urSoPPIlCGPtY4u/RgS4MEpBZv6f1c3yz
	dyH3PE2nE/BMkPZQiWw7bROfybttLMU3kZV7XOTrDLKCPm+rTYVyZFIvNU37jINtUMdyg8OKEYT
	6mTfI6xEy9Qs1wcRvqQHaswpXMMkFzSxOCr2COr33UJ+3kaqQ1aNnqwEugE7RheqQGEzR50HBD3
	cxYha8IfXyI8DEXZ092W4CEBk3C/Qy0E2F8zlscMksvRFfXOtlWajoNJr36V/wEtvegSUYaKPtg
	r3FInmMTGBu5DPvzol0g6P9jVsppw6caoOnxlB/85ScCPt8v6lPsAQeNuax1ZrXfGDd1sYM=
X-Google-Smtp-Source: AGHT+IEwWHNi7IQsbUhRzTa5EaiN1kvuKqLSnlU0bMScHgsa6KhYkSTpXYrAZ3MhbyuWmkaFjc4G2g==
X-Received: by 2002:a05:600c:a51:b0:450:cfcb:5c9b with SMTP id 5b1f17b1804b1-450d880ac83mr121438035e9.1.1748947726161;
        Tue, 03 Jun 2025 03:48:46 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb05bbsm154084245e9.22.2025.06.03.03.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 03:48:45 -0700 (PDT)
Message-ID: <f8f15489-8b31-4672-9fb9-161c7c4599dc@linaro.org>
Date: Tue, 3 Jun 2025 11:48:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 William McVicker <willmcvicker@google.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
 <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org>
 <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com>
 <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com>
 <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com>
 <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org>
 <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com>
 <f2d149c6-41a4-4a9a-9739-1ea1c4b06f4b@linaro.org>
 <19ccc09c-1d6b-930e-6ed6-398b34020ca1@linux.intel.com>
 <c1c0bacd-7842-4e9e-aec4-66eb481aa43f@linaro.org>
Content-Language: en-US
In-Reply-To: <c1c0bacd-7842-4e9e-aec4-66eb481aa43f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/3/25 11:36 AM, Tudor Ambarus wrote:
> 
> 
> On 6/3/25 9:13 AM, Ilpo Järvinen wrote:
>> So please test if this patch solves your problem:
> 
> It fails in a different way, the bridge window resource never gets
> assigned with the proposed patch.
> 
> With the patch applied: https://termbin.com/h3w0

above is no revert and with the proposed fix. It also contains the
prints https://termbin.com/g4zn

It seems the prints in pbus_size_mem are not longer hit, likely because
of the new condition added: ``!pdev_resources_assignable(dev) ||``,
pci_dev_for_each_resource() finishes without doing anything.

> With the blamed commit reverted: https://termbin.com/3rh6


