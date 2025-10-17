Return-Path: <linux-pci+bounces-38506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E39BEB37A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 20:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B23F408572
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F392FD1AA;
	Fri, 17 Oct 2025 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRQ/g5jr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A830505E
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725658; cv=none; b=G8L/ta6CKZRVJTN5UDFZgDsLSKMulNQeiABeUo68ma+/c92F6HfLV2VJCLU6KcoyDf6oo7rC9dmKNjtsHKSC7Ui/Ymwsnetj0SFQ96NJuNGPVS+TwrjsrAIHBketCYGO+uDjD8tAG2sVdfXTdQyjSRUeeoa78dFRiR0+bnvUp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725658; c=relaxed/simple;
	bh=uQMVWtUguHqyXYKwfPXnmVSt9RtvFAq9F4QYgyT44jg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MeLyy6yAT88lM4TderB+qh7zMSJQkzz7ODfdR4Kdob8+y9MP4OW1M3o1iuE17xOHxUl5+cMyUtLNr7N15MUAg35AYM1PJFWYp/5vIwuXYN4Ll0dw4n7yVGE9lRnKA/DIorYbIFRIWLj0MHzODPzDdEJD9D2dK5pyGP1BiVCkBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRQ/g5jr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781206cce18so2389379b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760725656; x=1761330456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e9KlW+lpogSSOPGbpGvaXOe7oJB/E4tzSfCU9kHdDzs=;
        b=iRQ/g5jrQwZtJZ/SPvNrDZczK4sN1xkgLBQaOFkTGi35JSzXXEnwpyvV8MXeLEnkY2
         t2WA/O5Wp86A7dG2X4l4wsb717717gV6mA0HQVjvT4HelmoTLPvmYZYVFMTIiRWRCSek
         nJfNab+0WA69AUgmsehm5EjxTPUKKJDf86OO67rTp0l+HoVwahn3qjBIlSugZr9P5vJm
         ZQNNcErWKjeyD5WCPo1hkD9WJaP8+/LuX73JwG8ovZtl/HaIpfumwDwpi3myRoRyDJKE
         s/adn140Q+fFjNkHASFQ19d95uGF1cH8JVBIl87fsUi22Np2L990wYlr0W6rzjjYFjPc
         ewAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760725656; x=1761330456;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9KlW+lpogSSOPGbpGvaXOe7oJB/E4tzSfCU9kHdDzs=;
        b=II88eHAGwJxyAnweVZVuZD1kh3oojsWNxisJXTf8QjS12PGQedfcxMr7YVn8KH73J4
         2xZK+rRaYrBplEhvhfM1IdlFnsikHnnY6B6LF/NTWJVAm9XFBSogrYn2DoCmfQHJd3/o
         2oNk84+5zwqlHoxeFJPC2xHeNtYXPzHkEnVxyH11akyIF8aMOzvg7XrB+Jbmh384yyxa
         5a94FEGpmux08s1KRftk1GE6m/cnOpoNcBK1YjIiGG052Lql7lEWAmKfCTV3fWZOF0lB
         s/OZKJMv/cthOGXLhbaUxRF1LjU1Wqr9LXJC4brJ0ogECTTfCEE+txEE3kw7f1/EgCsP
         pl0w==
X-Forwarded-Encrypted: i=1; AJvYcCXL3PQQw8tMUp0VR52kc9QrnmL/Ugj0RpWAopo2KOuwluFknt+EHKmm/ijrM8OLruPZIkBADcy+UjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfUjaPsEBEoyxZW5f/ZNfwgxjINrApuaObVsz0dZHGdB1lgqe
	0cWgDZBdJ0YODpOOTKvuHbHDfcL3escRTmZ/c5ShIwolmJNkHibr9IiONp4oGQky
X-Gm-Gg: ASbGncvj18YWymsB2lWOuMi20zeK9XcHBsKR5ugB0E3m3SltkWABPqaejf/74n11+Xo
	jwA8/3OAeov9E4GYuaOdYsIsaGxYPqWkmbGHNZbMTJdxhzkEdfMrHzCsbSZ7Os8fyfxcfCDXjz3
	ltrkKkosPKqno+CsBijP9H/FX3cG5UrGewiw2Kz5b8aeMV6SHENGDK6zC7TdF0C+Cko9+D6hQj0
	SYjmrt4OeFn3Tln08iUf4PYBUMkXmJhgsTtnsPjny0+XikXfcACk1Uo7rzD/P7gmfj7Q6TQ/poQ
	gjCY+V5fl6Ue+gHsSRRahLP0b6JqoCGQRJUvejAjahhFLbd+OpLnwhjxCKJFMCR0fB55sNEaeb4
	LUqWdlJN/iD56eMtJ9T2vslKuMvmkjeIpTIVIqy5lZ7tdFzoOxY6fvSdVB4BJuiGCZOtTx543Kw
	kEyKR4MGVUf5jtgPTMuzoOyZSAqTKCxAw71Obg
X-Google-Smtp-Source: AGHT+IFVd7y/Qyh5ATMsYkQxTDgYS9+NlSf6Mnzo3x3NdEUjkrVLtHGmbQu+5MVS3w84oY1mQ/OE0Q==
X-Received: by 2002:a05:6a20:9149:b0:309:48d8:cf1d with SMTP id adf61e73a8af0-334a78fdda8mr6800910637.18.1760725656169;
        Fri, 17 Oct 2025 11:27:36 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.200.138])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7669392csm424003a12.18.2025.10.17.11.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 11:27:35 -0700 (PDT)
Message-ID: <8c6b4be3-fec1-4097-9be0-6bd5d352c2e4@gmail.com>
Date: Fri, 17 Oct 2025 23:57:27 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: bhelgaas@google.com, kw@linux.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lucas.demarchi@intel.com,
 rafael.j.wysocki@intel.com, Manivannan Sadhasivam <mani@kernel.org>
References: <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
 <b144ae1b-8573-4a71-9eaa-d38f38e83f4a@gmail.com>
Content-Language: en-US
In-Reply-To: <b144ae1b-8573-4a71-9eaa-d38f38e83f4a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/25 23:52, Bhanu Seshu Kumar Valluri wrote:
> Hi,
> 
> I want to report that this PATCH also break PCI RC port on TI-AM64-EVM.
> 
> I did git bisect and it pointed to the a43ac325c7cb ("PCI: Set up bridge resources earlier")
> 
> Happy to help if any testing or logs are required.
> 
> 
> 
> echo 1 > /sys/bus/pci/rescan
> [   37.170389] pci 0000:01:00.0: [104c:b010] type 00 class 0xff0000 PCIe Endpoint
> [   37.177781] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x0000ffff]
> [   37.183808] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x000001ff]
> [   37.189843] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x000003ff]
> [   37.195802] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x00003fff]
> [   37.201768] pci 0000:01:00.0: BAR 4 [mem 0x00000000-0x0001ffff]
> [   37.207715] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000fffff]
> [   37.214040] pci 0000:01:00.0: supports D1
> [   37.218083] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
> [   37.231890] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: assigned
> [   37.242890] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: can't assign; no space
> [   37.251216] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: failed to assign
> [   37.258309] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: can't assign; no space
> [   37.265851] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: failed to assign
> [   37.272896] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: can't assign; no space
> [   37.280439] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: failed to assign
> [   37.287459] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: can't assign; no space
> [   37.294986] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: failed to assign
> [   37.302011] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: can't assign; no space
> [   37.309536] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: failed to assign
> [   37.316595] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: releasing
> [   37.323541] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: assigned
> [   37.330400] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: can't assign; no space
> [   37.337956] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: failed to assign
> [   37.344960] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: can't assign; no space
> [   37.352550] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: failed to assign
> [   37.359578] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: can't assign; no space
> [   37.367152] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: failed to assign
> [   37.374192] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: can't assign; no space
> [   37.381709] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: failed to assign
> [   37.388720] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: can't assign; no space
> [   37.396246] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: failed to assign
> [   37.403795] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
> [   37.410513] pci-endpoint-test 0000:01:00.0: enabling device (0000 -> 0002)
> [   37.417796] pci-endpoint-test 0000:01:00.0: Cannot perform PCI test without BAR0
> 

In my setup is pci topology very simple. Just two TI-AM64-EVM directly connected to one another.
One acts as RC and the other is EP.

Regards,
Bhanu Seshu Kumar Valluri

