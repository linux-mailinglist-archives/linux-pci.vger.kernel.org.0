Return-Path: <linux-pci+bounces-19847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 966CDA11B58
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88761888D95
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC62522DFA5;
	Wed, 15 Jan 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jP3aZsZv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9D1DB123
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927757; cv=none; b=bAVi/v0mz2VrP/rGc282vlV7zraAbtfhEcKuPJhXV4Px2naXUTEsUSFi+s/ApHyRpbfUhUuzS1+1voixg0yxT8xNao8Bd1d38S3zduozcwmQdUtgMtC0mASF1sIWShvB3+2FxPQf5O3KkP1V0FTTOBu0p1vlqreHRfZJa4ZTbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927757; c=relaxed/simple;
	bh=8cc6q30HINn+H8F4o6tidpxGU7o+77JG4MGNhkD3R4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sDXYX79MQ5XvlYXzikxxb/YH+Vb9nplY0FI6ULMQafj6ekQCVMtZ/4tgsKrfFRyUzztbqAgy8ZJ0t/7rtFSJNAi5yEYK/TsCwhYXlMIGuRKUZLIiZmFO5yV974Ehetge2tH4g30l1TS5VLQM9MQgplkD+4EJ0aJRAL9UXXJghC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jP3aZsZv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2178115051dso117582735ad.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736927756; x=1737532556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aauZSnjY7VuRJhoKYPbfgJ+Y/MzZjQ6GOIEoElbLNHs=;
        b=jP3aZsZve7Q/5WAvVEn2K1BJX3XqRj6c2IPAszJts0N+zaOCMPJY5Rqj3PI3d8ApY6
         hURGPi06tLHkh/tmA/NMbQIhCuI5z8KKeoHGL8tFSwaxlE09NlfNyN17VjKdyT/+1sIY
         OTu2Ly/YpnCzgoDCwrFao3xP3r+jN5J5wjdsy4HohpypbCeWhrJJN9ZD+fItrkWUAaAd
         1wGnmPFb9J9duqdVS2v3Rp+hK2q/65SSuB91i2Q9/iUz2PbXbeQE5aFB9qUewRifJm2q
         Gyewr0yrtqP1QyIBEfp+TV4OSDS+gX+iDKgYxa5X3rFJyGc1TEgqBf4eHy75pwdk5xnL
         ASvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927756; x=1737532556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aauZSnjY7VuRJhoKYPbfgJ+Y/MzZjQ6GOIEoElbLNHs=;
        b=v4vQbaR/Hyq7mR77cUJy3ZLFIdDlvJgEDjslLjDAeO79AafwV+MGAOL7W02JwwKvCV
         KTlfDbSml/Fc5QlFtWtCEtWfiTc4MUdbQyTnawHWiF7mj1z2bYyz4mL+6l+mUkboyAP4
         CRC5cDkhH4+gzwhRuw4YuHy/Vf0hGJaGKTWTXvJt9kFmxnVVoQNo9fDNBFrmiaPihJYO
         tiqhUfyG2eTNX77VwPFbRzYUAseC+21uTA9mcZl+m9JfPN3mMmEZiH5yWC+2JTJ//b1v
         0q1GmoWsar/SwO8t7YU86PSKFzP78yU7OQVc5KxX969XzL6e4dHAe7QOjtyOfxj+QF95
         jl4g==
X-Forwarded-Encrypted: i=1; AJvYcCXmXt0Vc6mNVAjWUDBCHzdrLYdIxFNHq/xYKpXAiNrH7hJ9MKJPtsze0chQ9v1+CH9BkhIbY1TPaZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVjAo/ZRBvz2NBKhe83Hlv6XW+pb5pcU9Drr8CyQl43AT1JZMn
	pqUMG/El2t36xAVTtrrUelb9yBqBolZDufWA5zlQoeR4kfdrWY1CAlZSlFP3Cdmqj0tcgyHwajI
	+cw==
X-Google-Smtp-Source: AGHT+IE4II7/t4slcIGxdy+Nt4/8uptoTJw0BLzw8WGi86ZzO9v8NlFN3nQrVcNqtFQ8hUpfN3idXRccwLU=
X-Received: from pgbgc5.prod.google.com ([2002:a05:6a02:4b85:b0:800:502a:791e])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2d09:b0:1e1:ba54:ffee
 with SMTP id adf61e73a8af0-1e88cfd3f88mr41494971637.21.1736927755947; Tue, 14
 Jan 2025 23:55:55 -0800 (PST)
Date: Tue, 14 Jan 2025 23:55:53 -0800
In-Reply-To: <cover.1736341506.git.karolina.stolarek@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1736341506.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115075553.3518103-1-pandoh@google.com>
Subject: [PATCH RESEND 0/4] Rate limit reporting of Correctable Errors
From: Jon Pan-Doh <pandoh@google.com>
To: karolina.stolarek@oracle.com
Cc: ben.fuller@oracle.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	martin.petersen@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 13:55:30 +0000
Karolina Stolarek <karolina.stolarek@oracle.com> wrote:
> TL;DR
> ====
> 
> We are getting multiple reports about excessive logging of Correctable
> Errors with no clear common root cause. As these errors are already
> corrected by hardware, it makes sense to limit them. Introduce
> a ratelimit state definition to pci_dev to control the number of
> messages reported by a Root Port within a specified time interval.
> The series adds other improvements in the area, as outlined in the
> Proposal section.

Hi Karolina,

This is a common impediment for many folks that want to enable AER. The
excessive logging stalls execution, making machines unusable. I've been
working on a similar solution[1] to yours (i.e. ratelimiting) with a few
differences:

- ratelimit uncorrectable errors
- ratelimit IRQs
- configure ratelimits from userspace (sysfs knobs)

Hoping we can collaborate on a solution (i.e. take best parts of both patch
series).

Thanks,
Jon

[1] https://lore.kernel.org/linux-pci/20250115074301.3514927-1-pandoh@google.com/

