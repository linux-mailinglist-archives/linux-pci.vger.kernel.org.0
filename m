Return-Path: <linux-pci+bounces-12573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F3F967AF2
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8121D1F21B1D
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3C376EC;
	Sun,  1 Sep 2024 17:03:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81A026AC1;
	Sun,  1 Sep 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210181; cv=none; b=ZLm4Y5IGnsfK2YN2PWLN/eL84K8Em8Y6lbR2dt14G1+bWBLb8UgRGGfqYwDNaTC2t0pSXPndMfPCFvhbCpG2R4YkbE+Av+6IXeU5oz29lQ/jgBjbswwLdzBN16sFUvtX/t7a6rESeo0oo1OKqiP8Fuyb64j9ZjDrQV0I0lbmCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210181; c=relaxed/simple;
	bh=OVNQjqqowNda7FgC3RM/nsXySeZJ1Yhvyh5sDY8cons=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSwFttST54+7l9Jt3zxlYcHHCLdLMvpdqCMkTOhxGOXqcFrd+A1uPL/FoS85KofNq+lZb1IrcdypRFSDlSysGBq2NOIUfE7ZKqLGNHG2Oz0VlFkGNS8a9rGN6yEs9CFEwfrm3pLF1U+pfJ1k4TTWQJ7SR+KfRnC4YkH68l06Ekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7141285db14so3027748b3a.1;
        Sun, 01 Sep 2024 10:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725210179; x=1725814979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgG5ufTwqxApKfn/2Ijfk0aPvo3cirPxCmRZrhOI98g=;
        b=ZMN9IIhzad8tkyQAcVjL77AWygFgxvApuDzUI438Boo4PmWBvN3h0HOtVAkLHWTCVv
         BKGy5BQTqkG3fOL+QmkGBmDMCgHgMTfW2ws+eZ2AKWGwuUD7ktEwfrWNTRY81EVZR/DM
         gVwkbkx+NTs4XHZ4hOwwuh5ykPhDvOYziUUE0guJyYys8Aj0dv4ZEh/c+jH4DSIcO+xx
         lIy3tcBBDClpweDQiWMuOUhAJq3T3Akp2rKo54Vi1JKwPsSfWL/eOHvozpyfOPVolqYS
         zWYVq/WT2xzW8HdwtdvcIKIU9yApJ4wnZdoTMiAjX5nI6pjAPVYAThP+yforXyZqEK6T
         xpYg==
X-Forwarded-Encrypted: i=1; AJvYcCVugNW79gay6CZ7aNLMfnogy6hzlPFeabPZgiH/ksz7HLYnh3NcW6Jhlm/VJUYeG2j7Zz34XAsJ7TQ1@vger.kernel.org, AJvYcCX+gx1acDuBW6MAf3udLV2tPxC3T7ZjusuOszcahDQSl6qhAdsHPkn1egSZaFkXdX7EojUjZ9X8aTEQ+P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUVyB1ZMdaBWiKKi8ISoSbaFqvTjnlu9OyLFzADcIbkmxvtMEb
	Mf17Lb17BQTW2dCnsUISL8EvX7KlA2SLKjzCxvehaP6ih1IGzlgF
X-Google-Smtp-Source: AGHT+IEg/ZRVA7BCDFTqqBOn/0MrVURmNeBnRZWbU8iZhh7zZNHo5SCYcOgYXLzH3ki1Tcwtd50NfQ==
X-Received: by 2002:a05:6a21:394a:b0:1c6:a576:4252 with SMTP id adf61e73a8af0-1cecdee3d61mr6904510637.8.1725210178837;
        Sun, 01 Sep 2024 10:02:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77f487sm5253322a12.42.2024.09.01.10.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:02:58 -0700 (PDT)
Date: Mon, 2 Sep 2024 02:02:57 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Fix indentation issue in vmd_shutdown()
Message-ID: <20240901170257.GI235729@rocinante>
References: <20240901092602.17414-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901092602.17414-1-riyandhiman14@gmail.com>

Hello,

> The code in vmd_shutdown() had an indentation
> issue where spaces were used instead of tabs. This commit
> corrects the indentation to use tabs, adhering to the
> Linux kernel coding style guidelines.
> 
> Issue reported by checkpatch
> - ERROR: code indent should use tabs where possible
> 
> No functional changes are intended.

Applied to controller/vmd, thank you!

[1/1] PCI: vmd: Fix indentation issue in vmd_shutdown()
      https://git.kernel.org/pci/pci/c/4654cf52cbd0

	Krzysztof

