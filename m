Return-Path: <linux-pci+bounces-17264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCB79D75DB
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 17:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A82AC4475E
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64DC1B3929;
	Sun, 24 Nov 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNTG+nBf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517FC166F29;
	Sun, 24 Nov 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732460842; cv=none; b=iaEJSqqgWyayFJxCO3PxEKkRYkka2p6QkL4YI092jK9oAVzOQd04DTCwASMCG/sUcXVvAH0G0tt/BMJnB8sz+aP7Aiuy+4F8MF+orQUdwqdu+mYtD+127qFjwQexRkut1ljGZldHxJX+QWZKsqsiD+82gwP7dfQ1E/R25naJ5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732460842; c=relaxed/simple;
	bh=29MJ8sYwFKcFWGk8rIN1r6kbK05u7kw1662rEDQQqNU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eLDf7Jeu1FlxppStkNshT9ZS6oZ06T0DeP94+950xGm5bH8jA/A2ogQS681VNopmRjEMDrEb1S8v2yaHCkeAnzC/+AjNaqUHZ/cL1cWYgF6J+nkKSEPT3Wx9b2bXRkuhzLj4Xa3JEB0BFgFtN2SZSt66WJDdor2C+9292OWhlCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNTG+nBf; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e382e549918so3034694276.2;
        Sun, 24 Nov 2024 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732460840; x=1733065640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7vDoUwVk54/2HDm8WhQ/hokgEo26iQk0+d75grJPQqM=;
        b=gNTG+nBf/7mWSlIoeZhuZjoIJm1h4JnUOBXw2K/D177zJGKjeUuWJ+WMNnjKIT72/L
         66ML+2oubaqPRo8nFLHBeIAYJPUMR8Nful0AZOj0E5ShSeMqkRPtrwvX9bHWcNC0O/WG
         wSSnHakEvkOxQY3Iu+ktbLLHQCmY1IhMlJo8wf5pKDv062C/yYlz6H7pxulYe6GlW7wt
         VA44kdICyzkFrhz4WXHWXHYU1TIBcsugIAZBI7fhzbfPkPVk/+lApYHvyqdnPKRjcMis
         DeA3SKS69YFYdYOuG12bC82fMDU00VOlub3j1RvOcDbp+7YggsxMb/N8lDdJ9on2b39z
         0z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732460840; x=1733065640;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7vDoUwVk54/2HDm8WhQ/hokgEo26iQk0+d75grJPQqM=;
        b=t4WPyD/W6QvsU/P+9apKvScIfpTExPuouyuC71ofxrBf7+Y5RvTo6Gq4d/iRl+ECO8
         d+PPbLOpCyYsr9Xx0d/N4HOyIHO7H7/OTPnOFyj543614EdLaYkekEikjHHC2rPullJX
         NjypnSu6Hray7kJH2y1irvILrJDQ96fHG+k6AovRQLN4oA/mAS45JlD76pFjQVHmZf3u
         AU0fh6oiR0q9zhsY42uO5RJUPO5kKdZsuTZXi8xIG3s1y6WZ5j1Rq8IfElIkMDnIaap+
         QoS1GVAxM3LViOJyGDoooLYwan5DtAGUJ5ykWTVUd4mhRj5v5jWlWCnyk9MXuR8kA4vT
         ZzMg==
X-Forwarded-Encrypted: i=1; AJvYcCVR5TdwtPq5cHo6NuvNskMPczyeU8fBqccJgDNZKjnScliEHGDsUqNQSVWSJs+G3ivW1kQ5ZSA7z3NQ@vger.kernel.org, AJvYcCVWwc/hRhCjE1hrKTBER/D3KoQzu69ZIXykfoVavc1wQtDFmXBTA9pBz+M+Dg4hl9J4O6SuBppeQEOs@vger.kernel.org, AJvYcCXYCspAFGosILqMpfcwhgn3xTqdKsz37TqVh+KJ8+2KiDB5g0f/qZMtrHiA6zET2M85DquEVMUe4qhr/Lvx@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzp7qhMERmp3k0PbfoY74yggt9yprwD3UBwgreiJKmMFwYKWt
	UwO581FJJPUI89myMARENRCLCavmV1MvIs8UzObdMZ7wL9rswQbzulO1WciVhViSwaSnHrsiMTM
	ifYjyv+Tm4ggEIcmpNa/8S2P6G2E=
X-Gm-Gg: ASbGncs7CtnowAKs/kNesSbyb3+e50th9gfgNF8PU6G35AQ3CPLsYiEsR09uORUJueI
	v0WtxYzrnihqSExsXgFM27kHFSS0DdH1E
X-Google-Smtp-Source: AGHT+IG9ahPQQV57NbUiEfytAhXwmIMWj+E8j9L72G0f1AQV4HUtOjvOrCGoOaHQeT99p4rPqWI5dxAo1AKm9fZH/sA=
X-Received: by 2002:a05:6902:1b06:b0:e38:c692:14a8 with SMTP id
 3f1490d57ef6-e38f8bf0a9amr8723492276.44.1732460840164; Sun, 24 Nov 2024
 07:07:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Sun, 24 Nov 2024 16:07:09 +0100
Message-ID: <CAMT+MTTiimUvH7=T-zHsGAU0cDSYcyJL9p_jWNE3K+JKaxQ-Aw@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] rust: implement `IdArray`, `IdTable` and `RawDeviceId`
To: Danilo Krummrich <dakr@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, 
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com, 
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, Rob Herring <robh@kernel.org>, daniel.almeida@collabora.com, 
	saravanak@google.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Fabien Parent <fabien.parent@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On 10/22/24 23:31, Danilo Krummrich wrote:
+
+/// Create device table alias for modpost.
+#[macro_export]
+macro_rules! module_device_table {
+    ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
+        #[rustfmt::skip]
+        #[export_name =
+            concat!("__mod_", $table_type, "__",
stringify!($table_name), "_device_table")
+        ]
+        static $module_table_name: [core::mem::MaybeUninit<u8>;
$table_name.raw_ids().size()] =
+            unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
+    };
+}

This needs a cfg(MODULE) or similar, otherwise it is impossible to
build multiple modules
into the kernel. (See
https://github.com/AsahiLinux/linux/commit/b63a09090638ff92993c450132387a77e1e68c9a)

