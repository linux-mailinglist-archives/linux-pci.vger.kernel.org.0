Return-Path: <linux-pci+bounces-21539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72042A36B4D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 03:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C350E3B1EDA
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 02:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E43770FE;
	Sat, 15 Feb 2025 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVGqCEVf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F0DDA8;
	Sat, 15 Feb 2025 02:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585463; cv=none; b=NuwzVm/yWmR2Gy3vp2JzGIPuSfdZMWtcZY/5vHCE6KWfG9tC9rpQgKzTxg2JqZ75xhD7871zzcR+9rLR2/zZLMQpXILV1nuKRGj1yUEgVsM2l86AqrtzuFcNGYk5BvUHVoyG7czZD39SpQuF8YpxxsQfz913A3oDoPT+J0GHTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585463; c=relaxed/simple;
	bh=F5KisoC8Tthb+v772aLV0rGOTT3v7PraAXuSa0ZJRA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bdn58YFMg5K4w/3HFQNX9VJn8rMNXHAlUFS2fDIfTg7/QlMjRUFT7fvRg52aTYWopBarLdfF8rXe+l4zJm0LGtIyWd4eQwgmzvaYmolJtw9QKX3rfIebHY7loSCdTiq04Mrh5yJrmVAgRpESDxcOYVrw9o+DFxlVuEtFDbUU14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVGqCEVf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22104c4de96so4775635ad.3;
        Fri, 14 Feb 2025 18:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739585461; x=1740190261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cgsra6bFpPQ7HN+6ev8KDhCx7x/FZrXI1rWFFA2/rG8=;
        b=MVGqCEVfuwcPscXGegdx9V8OhA2BkSDgfxU8bqp1YqyBKBSryljPdI6ZlQMTTb7zUG
         hbPdxfLELjT+f2y/Pi0EtecAsW9X8RENdR9joPuKdPmv3YUQhinm1vKO7Ziep2j28d/Q
         Tr/vZHlayct7LxspaFKfHAAoPpwF6zi4ohM1srjlSGsVT3gS19sbvOhU5eBM8TPUFFqg
         dn1m4ZT4UqMBU12WvDbvqH3IdDwMSVFRFLRvf4F2gDFQhM96m7Y9EMWKYsfwhPSgbv8j
         czaR7eQCgL9k0Dzq08KdQ52ct8rBQtL0coa5c+yRPBYP8IvQDIJ+bYsjsFYCwMjyG8qb
         fTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739585461; x=1740190261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cgsra6bFpPQ7HN+6ev8KDhCx7x/FZrXI1rWFFA2/rG8=;
        b=TtcjFDAolVdVzovJbnqOx0iIjXSkATIfWyMADfbpUVgurhIyaPeDSiQliUp/MR2DNS
         ZV3WGfhvGQPYbM0u4lGUcliCY7wKXJhivOteaIUQweQdEEHnUJvnTjVhxt9AhH7XWkMW
         BUIiUFXQ88Jz0OctaDeuB6tDtM+uolpTGya4WsEa40Hv7jqO05+/feMDZKgb9z/JPIRT
         4/42Fd34ASAdQE6DIC9VuqWmPNlp9heiOBWDVbuBbKsEje4XOhv+z/XsoLIFbf5fUg0J
         bkr2siXWoZt7eelcYmCn2gA4nru44yHI6AWz/i0tVz7WQIs6Pzg51J+9Tl4WWcYX2mp+
         FrfA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ch8aIFmPcobWOHrO1LY2DI1fqhoFWrj1CNkEgIDjQO9Ch20s/h6O+PBvKq/8bgnExdlZ5EYzCAKT@vger.kernel.org, AJvYcCX4BvIeIleCFN1Z4tC0WMD1ZjwhDSSSCE2m5y3AU//CJq8LyqOC4+zvm5G2Gkv0cLhsG1or4/egZyamnTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFx9FAR5XXHcQxkoHx+G+qeb7CjsVQiyXY9myeia2GmuDNLjRv
	yK20x/xHmdNfxxBc6T9XPgN4la3rssRIylpvNgFXec1RzDK0zcy8
X-Gm-Gg: ASbGncvT4909uS+Q6pAdjsXQKsw0cCF+pG655AV15iWrj8Si+QIlJG5TqB8cKVhkayq
	Z6K/Jmr5hWvBy1Jq4e03/ePjvfMJGVLrMSgqIxePY0Ro4GUfvPBDDMmgGhET5BB+g1Q+khpQci+
	t+G8dQ6NWRCC8KFBH1VyTYumC9ifvvIwiRTIU600qVVVN7HaxCeduVKjhtRpByNLYooCt1L1oaI
	oBoh/BZjGyL+QWKotA++OSi+7NBafaO4E8ifjAIjoJk292zqZBCYmo8c/DmAkKlde2FipRskt08
	iDoxt4GHGaYI8JGuoXfr0pBg
X-Google-Smtp-Source: AGHT+IHxkLLwpKOHi1XIzxumWsIvj/ijr9w69VL72lr3gAh2s8kzIVA/IAWOv5dH1ks0QDxzucWaqg==
X-Received: by 2002:a17:902:db0c:b0:215:9bc2:42ec with SMTP id d9443c01a7336-221040cf223mr21801725ad.47.1739585461518;
        Fri, 14 Feb 2025 18:11:01 -0800 (PST)
Received: from linuxsimoes.. ([187.120.159.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53674b1sm35362715ad.98.2025.02.14.18.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 18:11:01 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: christophe.jaillet@wanadoo.fr
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	scott@spiteful.org,
	trintaeoitogc@gmail.com
Subject: Re: [RESEND PATCH] PCI: cpci: remove unused fields
Date: Fri, 14 Feb 2025 23:10:54 -0300
Message-Id: <20250215021054.222787-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a1af3a07-1e76-488b-82f7-87b3a4907f26@wanadoo.fr>
References: <a1af3a07-1e76-488b-82f7-87b3a4907f26@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> If neither get_power nor set_power where defined in any driver, then 
> cpci_get_power_status() was always returning 1.
> 
> IIUC, now it may return 1 or 0 depending of if enable_slot() or 
> disable_slot() have been called.
You is right... ever return 1, but, this is a expected behavior?
Don't seems for me, that ever return 1 is the right way.

> I don't know the impact of this change and I dont know if it is correct, 
> but I think you should explain why this change of behavior is fine.
I submitt this patch only with intention that save resources removing the
get_power and set_power pointers and yours calls.

Thoughts ?? 

Thanks,
Guilherme

