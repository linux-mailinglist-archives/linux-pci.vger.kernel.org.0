Return-Path: <linux-pci+bounces-41285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E72C5C60165
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6FC44E2657
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93E19F137;
	Sat, 15 Nov 2025 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3f7cpId"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736818AFD
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763193694; cv=none; b=AiXGhyaiCgm0EMyg9utuVKzpmZcLHbb6kGcu/pDAZZLq7hqymWld9UiJS1HnqiQmGkVxleDwM0x/nMttIo53Zb4JEmLnZNDDbATnGWsYvdrJ/edRkrFtUxxr14rs+bxImNfU25LUyy++zD9rsKy0jqxOMQFbuR117cBO6FzbYxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763193694; c=relaxed/simple;
	bh=GPea8v+C6CZ4NaswYIQKCfHPmEXZ2BAAYp+oRZw7z+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7DnI0AU6EufdYoo9MehK7xDi0DkDbIsiWnvM0P0EujGxRQDBi620L4CoTHlOfs4Fn2iIYdCUi9UP52YKljFD6kJtL5OEelX9txGTJwNRX76imPG64wzDZo8cKp6xJca5iENB42BBIBom8YihBgd0cpyFOmR0jUatyU4CK5UlwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3f7cpId; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2980d9b7df5so26860265ad.3
        for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 00:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763193693; x=1763798493; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aAYAENnRQYD19CKiNMUWYlXpPcpPP46lLv9VD+gXegY=;
        b=O3f7cpIdplETii/DK/zOo9goDene2mvPKSRJ+RwJDkESv8unZgegYfjtDuLkk47xdP
         Jthnh3waPWVVeb6XlgAFvTIcWPctPUqhOclxt5zPynm3GSNaokTIL3EMsQduuGhdNadx
         9ARCDqxCoNV3DtlvXuM4DrEPZvvdbN1UynJcA6ek9vKBOu35ZNLqQ+u4WRz6nMQDOukD
         4+lK5oUEP3r4ZbogZ/7TGdMee0HdvrpDYtDetukdh+crgF4z3hjh1Bh93rsSc4HNJ5Fg
         XJBAlF8zxgbbyJQT2HFSZw/unnw/e4mA+vK4dgHtiKikMyWyogSzvfJrP4hn/cvzcYIS
         v/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763193693; x=1763798493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAYAENnRQYD19CKiNMUWYlXpPcpPP46lLv9VD+gXegY=;
        b=rV2tPlmSMGD3YWlNfBI0d3ZBQm7Yh5vF49m04ksD3yyhqLdYjst39VRpQ1RyOx8YbH
         8RizV4QToZJSKRLi0S8/OsT/ABJn6XV7xZIdjk/z0D846eaa0CQ2R88FSPyqj5sQgub1
         JkXjkB4VIzIRboExBXwoBI4/EHFa3VoiNJoCDNVIkGFo1DwZSEwyRG93bNsy+7XpWR6M
         r+6EAW5CPgrgzPAP8uJjb7wrdcyhk++LEA01haLviFehuVi+sgLwXQYNaKwNxtlUpi39
         9FHePOzCxtCKGvwSxozLSD6rCuXqZBSdzkDxEZfxkiNfRUlccS1bx0Xe0vLlU0G3UEf4
         cLWg==
X-Forwarded-Encrypted: i=1; AJvYcCXlkOAPD8w64F7QCwn3JmjyKVSGNUzWYXQjL0OMBJFn09ULtwoXPTMRmLoe7lAqPiqkA+pKijREB/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59PbIxgfWIZ5LzfQmBAgd4E5187E+zs4yCETFz7AFCicn0KrN
	SJVn+O66SyK8kT7adldqwH04o7e8kL4cqFvhdLc1nEp3HwFah7aCePtB
X-Gm-Gg: ASbGncv0fa1KWx2EahsZqFm4/401KZT3EgvSbl7Ujzzem99qLUuJ5RrKIE7sa4xcOl+
	XBeMQiIjsLFTnZnwFRAuGeWeDhlaLUxbZoAOkKBHk/W6/qo75GFA/ouTJz3GD/8Q4j4LzLZ5Zdl
	d0ndyO9hPUzb1KkPk+zDYBEU3wjLu9vzT/pzG6xoOQROa0HwE3JPfnfMYMI0JzjQP+ZHqS23qcl
	R16cmSUuGy9BdpsSlXA05OemZ2vWn2C6syAGgw0jdiO0EDr7cZamitbulQ09esADcXDijwQXgOW
	/+uCcksIkNIwzTQdE5mhcVYNkDdhyWisRX2GMRbjf0m+4ObKRLtehOSUdufcLtoKPr4Q6ulnQGk
	zkzm9NteM0efzKe+uwL0fKrU5s7coHmu+VDojYHQCwR8DxtBQA67xkC0F9HLI6pWTgxhs68Sppz
	hKuU5e2Hi8yhPoOaAuf8WLikIkIOQ=
X-Google-Smtp-Source: AGHT+IHEN2mRU40eTIFziL9jKfVUWLwIHR9DBbKHOJZB0CnM+M25iCaVtz2d2f+nVbVfs/09LVH2fw==
X-Received: by 2002:a17:902:d58f:b0:27e:ec72:f67 with SMTP id d9443c01a7336-2986a6badc2mr68510065ad.6.1763193692693;
        Sat, 15 Nov 2025 00:01:32 -0800 (PST)
Received: from 2a2a0ba7cec8 ([113.102.238.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c234644sm77467785ad.10.2025.11.15.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 00:01:32 -0800 (PST)
Date: Sat, 15 Nov 2025 08:01:27 +0000
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] rust: pci: Introduce PCIe error handler
 support and sample usage
Message-ID: <aRgzVyEMj2dnsSvM@2a2a0ba7cec8>
References: <20251108165511.98546-1-jckeep.cuiguangbo@gmail.com>
 <DE5Q13AXWVZC.1NRFHPA8CSO0T@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DE5Q13AXWVZC.1NRFHPA8CSO0T@kernel.org>

On Tue, Nov 11, 2025 at 07:26:42PM +1100, Danilo Krummrich wrote:
> Thanks for the series, I will have a detailed look in a few weeks.
> 
> I think this will be useful in the nova-core driver for instance. However, I
> wonder if you have another use-case you wrote this code for?

Hi Danilo,

Thanks for the feedback.

At the moment I don’t have a production driver making use of these
callbacks, only a few toy-level drivers I wrote for experimentation.

The main motivation for this RFC was that the Rust PCI layer currently lacks
parity with the C pci_error_handlers interface. Some parts of the PCI
subsystem (AER, recovery paths) need these callbacks, so having the Rust
side prepared seems useful for future drivers.

The sample driver is only meant to demonstrate the API surface and help discuss
the interface design. If the approach looks reasonable, I’m happy to iterate on
it or refine the API based on the feedback.

Best regards,
Guangbo

