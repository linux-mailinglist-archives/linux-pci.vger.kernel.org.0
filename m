Return-Path: <linux-pci+bounces-32444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F8B09414
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1521627D3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D21B20ED;
	Thu, 17 Jul 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ODgqzHY2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D057CA4B
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777492; cv=none; b=D9J3CmjtnLlRc1kP2P4kS3lApBnktVYIB3A/ht5vQpjlP6mees+gmom3StiMXiQ2CIBIefHGnGUiAcleb1cMvFq7T765ceZTR8eDkdhNzXPKRrfsNjOg3QkRKWurdz5QR0/gAdpSzYnxLT+ax9afW8SKRyyS8cc+KplEgGG6I4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777492; c=relaxed/simple;
	bh=7iKA54t81F7kAccwzTnplc+FX9U9Q5HiGJ/3nmO1jaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1U9DcblmUAw2JheNR9iLrN79TpX8KDv8SKncHYaUqzPFPYgJzkO1DndfRCBW1E/nWoZcuiGWhD+C4/NtzQ3k1unRs+5mLNjbU2+iDsi+X7JzyXuJrESUnYnJcY/CCzkxy2K7lFqr/ioZxohxkg7x3OeYLYN+uIgE6VwOPoDYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ODgqzHY2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b1fd59851baso929811a12.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752777490; x=1753382290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iKA54t81F7kAccwzTnplc+FX9U9Q5HiGJ/3nmO1jaw=;
        b=ODgqzHY27TzN86FIM+a0qEAZ1MaVlpzJKpUEcpNWo+jcGBR5btPEm3g8GWnenr5rmb
         nOmXNNselIxgCh+/uUuDeQgGGhN54lAwb2ZO3F7oaU7UnChBRIwG5jJA1junwqpeX08W
         v+oCMkxiyo6XPyWAj9VP5ghVHK5h1yGi4FkzHBpMz9J0gP9CjPmlCMle1Snupb7UT64P
         xtQpQKcQdpE237O1USc19s2w19Mm/Jzycy3U18ju9irPJSplg/W8kuK3aImNc6iFuKRz
         J5jf9v5YYhpNvQ1Xsee9MHJ2sqgle0i69AMth6xuoedKxVUNffRQZ3btwErYE9BR/qQ/
         XHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777490; x=1753382290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iKA54t81F7kAccwzTnplc+FX9U9Q5HiGJ/3nmO1jaw=;
        b=ns0xVFM/LUMcoA61gjPg044oMh2C9IZiM5Ga/iMie7b/H6AbIDsUpBayZp0CDU9q5+
         WKxNvWD518md2j9rjfvf2Y51ZZHEXVD3t+oZPI6dTVaa7tLqWGiF0ziETkVSU12DVxCl
         EKr43pUeDxR8sesj8sOUWtIfwb9RTwG9Wn8oNxqVsN47Na4Y5wHhP5ojqPeXHkqlq4sm
         YVmJyTgVV5ORiIEkb6RPU3CNv31uXXoAYLoQK4tWtXraXgPDa78g4ymZ6FHkKo7ReONP
         ybYmnPpLMq1MjoeZeCnSl4xxmARaNnm/791UYlG6QRUVTYkyq0o4hNMsbG9RIrYL5KXP
         zQZg==
X-Forwarded-Encrypted: i=1; AJvYcCXM+6Wo7IzGIG7lZfW9fX47hwOeL2d9Nk+CwIU9txCSm8wgROqPLBN/5VT1cAlldqAvwN4GKre0row=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWLeRL+KD1NlQmaZXs9DgUuMXO1MXhITC7B6TWOPWSP43w/TwV
	pXYnLXE/qWKCe/ZQkKU87AbAMwIP0X/kKOyFZdjsKxOUCQHL8SjFK2u5S5QPcpDWaoQ=
X-Gm-Gg: ASbGncsskVIvr//ESbqdYBuTFuNNk3+YgrQHQp6PrDq1sTNX1DMuk1HNcnHjEQv8el8
	AUde8iZobSiLGgi+DSr13F7mxqcrojBSktO9QHhIlk88DuvFEmdfYzvwB+gs94SflikViR9quRr
	Fd639zkqkN6kCpLVj6H/h4B4zHN1ASYYp9CFE3NVYMgU/srDtyPgNe3bYRXX7M5cSj9eyNppPOt
	DebcIlQFU6Y+46Ase0TEqJ7A1K+IeBgus7/YN5s4tw7L0EtjhAIh5n/cm0QukvvkS8otpgTINh7
	9XlyUXjhfBmFUqK6V8olNKzXHvidVQqDd20lkSEmYHID4o9R+oUbNHAKSnNZ3WG49eG7ORyinOF
	9rUL1iMLFYBlVwYN0Ap6xojifDavH+gRGEKMR9q6pzXmtBR8g
X-Google-Smtp-Source: AGHT+IEDulepLHdUHoTgUVIr5/9zKjc621R2ZrTT3BDd6EFZSc4AhhNNL76G2fLBh3MpLDiIh86vGA==
X-Received: by 2002:a17:90b:58c7:b0:312:ec:412f with SMTP id 98e67ed59e1d1-31c9f3df46fmr12573561a91.14.1752777489545;
        Thu, 17 Jul 2025 11:38:09 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31c9153a899sm2929366a91.0.2025.07.17.11.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 11:38:08 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: ashishk@purestorage.com,
	bamstadt@purestorage.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	macro@orcam.me.uk,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com
Subject: Re: [PATCH 0/1] PCI: Add CONFIG_PCI_NOSPEED_QUIRK to remove pcie_failed_link_retrain
Date: Thu, 17 Jul 2025 12:38:02 -0600
Message-ID: <20250717183802.22810-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250716193411.GA2551185@bhelgaas>
References: <20250716193411.GA2551185@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025, Bjorn Helgaas wrote:
> Maybe we should just accept that broken hardware exists and add quirks
> to limit link speed or tell the user to buy a working device.

I was actually wondering if we should define a new kind of
DECLARE_PCI_FIXUP_<LINKUP> which allows vendors/users to implement an
appropriate link recovery for their circumstances. In one of our storage
appliance product-lines we actually have a kind of quirk of our own which is
implemented to work-around some older Gen3 PCIe switches that had some official
erratum. Honestly we would like to not have to carry these patches, but there
wasn't an obvious way to upstream them. We could probably re-work them to fit
into a kind of new fixup.

My belief is that we try to not bend the generic handling in the kernel around
specific device issues because once implemented we are essentially enabling
devices in the future to have such bugs/interactions.

In the case of this ASMedia/Pericom switch combination I'm told from others
internally that its possibly that changing the link presets or other settings
may resolve the ltssm looping issue, but it would probably require
ASMedia/Pericom to look into.

Cheers!
- Matt

