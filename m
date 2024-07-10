Return-Path: <linux-pci+bounces-10040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD29792C9F7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 06:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778DE1F2392D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 04:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB252CCB4;
	Wed, 10 Jul 2024 04:43:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E43BBED;
	Wed, 10 Jul 2024 04:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586592; cv=none; b=NiYhLKQmizGbNtxPfH1HEc34cXGg18k0NnJmPbwwRJqSohbYuh/GXAciEV1bXvvok1AI/ArswaZzGT2OsR2vgX9tKMZ8Kj7rAH/o9OUl78+tkmCFKm2onqjYcW+WFc/dpbfL7X/8jC6tMNEpOPQD4HGvHQB95jSW14MO96nfcQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586592; c=relaxed/simple;
	bh=p4LTfwNBKrmq59TfMZgxbdhl1Ls+wseLjqChugXohBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/vSK5xHwBOsz3cIgShO3BvM347lPatCs6NJuA5BZgGakGYx5xteCEpOyLXgKIs2LhZMKsfIgfdh6KMRbBNP3tZ/jUpklTYwC96rqaUeMcH/myWfvr0uAmyT8fgstiYYrvGo14qBuHIpFrQLAP0SS0DQqFBAo8YRLGoz4rI1mEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b13791a5eso3745543b3a.1;
        Tue, 09 Jul 2024 21:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720586591; x=1721191391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBYghxQmqV/MFATMMEglTXAf1WvrRLlEEQWG723lE6o=;
        b=YvuuRoJAU/AA02E/BMYAevisE8jnbTV4mGfDzuSuxZyCw2rlnVZrT2VphdT8uzOZBe
         cnZHPfU6lZlZYcYhv9tA9kJu1AmeBl5t1Hf1Aa8AMM3/BaSpRosRFCuadLOTbocTLZg5
         9n5uuhCQZ4oq+vIV2R1F7wFE403mdUNDCk2Oiy+i6VWdskGGEyJzthBdX8BxOTqlPliY
         wtZ3LdpJtTgp9HoaJHLjNEsQgfLY5qMygutfK2aLkFOOz+jhab64hMfLriNeoHSbJXD8
         XQJleDxkLUC30i/ppKcADHXWtvAtOoZF6VCZFHJmHVYgwkRq5KITMmBaNkHOkKj3j4+J
         k6jA==
X-Forwarded-Encrypted: i=1; AJvYcCW6DnLpiEHlni0VwMwm3b24NWYf0P+xiZzBpNqUBA1lOcy9hrjr6Ua7FnaSVVoUX4TabGe7CMGK4Yox9vLcStUsxrZaQu1vMzK06Ugz5WQ2jI2w1Q64DxMZxhCWNlijOjMIIVkyiL3N
X-Gm-Message-State: AOJu0Yy+Xubp9DJdBIp20p6ozUwJplC8PR1QUN+tTBngjH/KwfKIU9C7
	63v2HKRiXH+uK5jhMpWWdSHGFhuMUZq83KT0K99R+Tp3f+qxnur8
X-Google-Smtp-Source: AGHT+IEAO4qJLwa4pIrOQy3qP7xw1m9erjS4/J/aulalRNzfb4Pguda20bTz3MpfO10uaj2g1qbm4g==
X-Received: by 2002:a05:6a20:daa5:b0:1c2:a69c:3cd9 with SMTP id adf61e73a8af0-1c2a69c3e93mr2514416637.54.1720586590826;
        Tue, 09 Jul 2024 21:43:10 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa9277csm10919612a91.53.2024.07.09.21.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 21:43:10 -0700 (PDT)
Date: Wed, 10 Jul 2024 13:43:08 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, airlied@gmail.com,
	bhelgaas@google.com, dakr@redhat.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, hdegoede@redhat.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	sam@ravnborg.org, tzimmermann@suse.de, thomas.lendacky@amd.com,
	mario.limonciello@amd.com
Subject: Re: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
Message-ID: <20240710044308.GA3755660@rocinante>
References: <20240613115032.29098-11-pstanner@redhat.com>
 <20240708214656.4721-1-Ashish.Kalra@amd.com>
 <426645d40776198e0fcc942f4a6cac4433c7a9aa.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426645d40776198e0fcc942f4a6cac4433c7a9aa.camel@redhat.com>

[...]
> pci_intx() calls into pcim_intx() in managed mode, i.e., when
> pcim_enable_device() had been called. This recursive call causes a bug
> by re-registering the device resource in the release callback.
> 
> This is the same phenomenon that made it necessary to implement some
> functionality a second time, see __pcim_request_region().
> 
> Implement __pcim_intx() to bypass the hybrid nature of pci_intx() on
> driver detach.

Squashed against devres branch, thank you!  See:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=devres&id=37c9f6c55cfd63a9e38a98b5aa1d7da75845c2b2

To credit Ashish, I kept the Fixes: and Tested-by: tags.

	Krzysztof

