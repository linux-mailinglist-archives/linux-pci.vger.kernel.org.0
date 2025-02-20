Return-Path: <linux-pci+bounces-21910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC5FA3E03B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 17:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9EA19C2C01
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5561FCCFD;
	Thu, 20 Feb 2025 16:14:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA2214213;
	Thu, 20 Feb 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068070; cv=none; b=BJRpNdhCpWQWe7+g/tTJbuHUIb3jqf6/o5YWnAxNnw7e2+N0qrvTRjWyYtzC7kbvXIAiMIdSeS4GwMyaX8mNo19Yol4HnfEiB5o3iJNMC7YfNQUlT+MXIknqFSZxhGT+oO5Sx6wMtQTWJf67b1d63Qk0QIZZ4tJHyMBHI0sJfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068070; c=relaxed/simple;
	bh=gzV7m1wnRHJuZrL0lRNYt11l206OpEpHCxUteP7zrpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIkbe+E0EYur9CXoSRZ31zVBF3t7VK5omYHMWDn7XfQWDTgTDCS0Tcp8dqMFgy+WNeR2RuF5dLSFFbJusvyjtPdqZSp2RO9YV/pukEuElPB9eGjPwgZ4ZoCTBApH6Kcawu7jE1dB2F8fquguHcr9sGjT7rrjcMYKwlXsOVgrmDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so2328546a91.1;
        Thu, 20 Feb 2025 08:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068068; x=1740672868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjApu7wvR6RLPV6pa18bAu5v7DCmsJtT4U5G+lnbPN4=;
        b=DqP3/0r5EDtVVwLq72tBw+adhpf/nrm5P5CHudkVpWAIrv5UbqMJ4cIkNVz618BOlt
         +t3V9i0kolWSSczDXxMU6olOa4VV6odvC4laF1ww7jRtScmfTrfbvnHyDeV03QBow5Ek
         IZUwDotuSyTE5/ustLbqQ8CpOxUONDq7wFPLbTZbpZr6BXepJbjwJtP7oBoEnOQcWZD8
         b8MDnv0FvryDgz6VNK3SKNbXe8T0M8DJvhKmKZedoRz9nAuq2n3ITIwux2SZtXh0G287
         YKT1c3qb4BOXuqLqX8deVrivQ66xcItZhASMnl6o5W3s71z1orOmsZyBhZNj5H5/vWET
         NILA==
X-Forwarded-Encrypted: i=1; AJvYcCUuTutKeg7FmCFo7lFs6rg5JEYti4QB4+vQoRWG/HZ/2VCvVzBBu6kovik3PVuurp6WSwdXdAWeWdUG@vger.kernel.org, AJvYcCWfxUgDarXzTzMBRsQXvnCKF9vZtv1ojUPzeILJc8XlwGo1WzB20MptyNL7TxD5+MfQB0E8uAL/@vger.kernel.org, AJvYcCX7T6RlRbhvYEbmWlSkAJJjaVHiFtMLf7jfqSdlNq0ll08tVob6llXptJu1c4XF4r7J15YJG8vyzbPG3Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmm9aQy+1COaZPTixm72hJphqd5ZQCJLCX1DxlV4SsCmxF7Rrs
	FOhnhh4e7RFPC118Mp/pzYMRCWz0MKFl9nueNgpfd7I1+HrWOZ7y
X-Gm-Gg: ASbGncth7Or+YrQfGBbA/zqWx40Ly4bdahLoQFPkgSexcc1+lZTkf17Z5ZEYjCGgWqj
	YX1OD7MkGvYBReaVFAmBSEdcfpri4bKIkJK350r5YIk97T6YGem6uxEGH/bGqaMVg0pB0f9XwGM
	E+tPohN3k2U9so0hbnR8oR0HFERTw6NY+YVuPtmaYvjtOuE/9b874sj2Jx80C8X70BRRzZXTXK2
	FUKbQaxU3jwwJMRwpPS2OPnxXdFcRo7cQBaGL81clH1p2NEZfbi9H3sskJpBuJZNNWIXqr45NQo
	6t+0iJdmIhwwC5KOVHvC3zGNXR1coojjJ/cBB12cRchTZXTXOw==
X-Google-Smtp-Source: AGHT+IE5g92tymOpqjZljOvL+f+6fyGVJuuKsTsrji+yeU7rzJLwpLIQ+0QHK60yLpl/epYrNk3qgA==
X-Received: by 2002:a17:90b:1e46:b0:2ee:fdf3:38ea with SMTP id 98e67ed59e1d1-2fc4104051emr28560885a91.23.1740068068277;
        Thu, 20 Feb 2025 08:14:28 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc13aafebesm13935035a91.4.2025.02.20.08.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:14:27 -0800 (PST)
Date: Fri, 21 Feb 2025 01:14:25 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: brcmstb: Fix for missing of_node_put
Message-ID: <20250220161425.GC2510987@rocinante>
References: <20250122222955.1752778-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122222955.1752778-1-svarbanov@suse.de>

Hello,

> A call to of_parse_phandle() is incrementing the refcount, of_node_put
> must be called when done the work on it. Add missing of_node_put() after
> the check for msi_np == np and MSI initialization.

Applied to controller/brcmstb, thank you!

	Krzysztof

