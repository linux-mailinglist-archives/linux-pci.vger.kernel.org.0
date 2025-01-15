Return-Path: <linux-pci+bounces-19844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013DDA11B42
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523AA3A9891
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C322E407;
	Wed, 15 Jan 2025 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTN1X59f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0FB1FE44E
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927413; cv=none; b=q3Xx5RaTzhnjkTEHjM9gg6UP6HgbPuExShWdmaLS9YTPfg3sIW3xaPBgr5fKhXWvudxb7Bm7w0/JCVFf6DujVETLyuA3+86/d1ovC3EWWSlp22UFCleCMljcmm9OTE4SVkt1O/2OaUyWSUAd8MWncT2jY1jcb/t2XdOphvCW164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927413; c=relaxed/simple;
	bh=6Ly5D3dxHaQrbTqI0GWPv+G2uPrEXs1izJq1aCHOKt0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XQMaPRYYShuz/5+blk7pquvgmVyreKT1Bc2QoEAFavIJ9TeLeJLVJDKs726e3UOR72nZXOGI5lzt/P2Qly+v1pCfEipIp3Kb1tnL7Gk66wxsqH/481dVmUKTiFtgmW/SLI9/nAVKTIILgZ2+zG6aYM57FeoRIFMfEbvkm9ECy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTN1X59f; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2efa0eb9cfeso1268361a91.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736927411; x=1737532211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ly5D3dxHaQrbTqI0GWPv+G2uPrEXs1izJq1aCHOKt0=;
        b=vTN1X59fz0nfsQFxHszhc09S9bIJBHwKkvfHW9gg55vCw04h1KDNs5qs+wRYf+Mro8
         matZnPEorREYdD81fSakB7B6cLdN3Q537QXlpyYlXfAQ83Sefs8q0+J3kneKpUkJMpan
         kuR4hrZLFeDNt92vNypQc/G0dH9+BJU1KPWYRNXb56sL7RJWby5g3kTY9bC5zY25YTiO
         cVf4Zze14VOU+MAZqtQfwNcRENLGghc2XiiM2D5KbPSGgYpRsg7UVWsBXAlLuHfYzL35
         4y/umNnHXLtTcacP4XwewbxSHoCVhGLJLRP3004qAeieqy4Vz5pRxbDOHA02Y+kIpU0K
         JtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927411; x=1737532211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ly5D3dxHaQrbTqI0GWPv+G2uPrEXs1izJq1aCHOKt0=;
        b=XTNsnqwxhiPOmgWe3cRzBRIdocVHSzkq7b4MxsHWAFUckgEFZ91PpVW8Mgxgtauf4h
         VeNRIqmNEw3J1BdQXoL6r23UGeyeRNMEs+f+zOIIP0y//Gzad6BEtRB9QDFAihTXu/Fz
         pVqGdNMpKC2E2hb9n8TtuMOtCzMabqnV1iC9JOqftyez6agIi4cL3uFYqX5gpJWgeD3L
         /nPAO5gyUuo3tAP1dUbpNBpQUWC82bkErFdcuVtj8JCZnonSd7wNAmsuaR2lRSWF2UAM
         LPsywoJrhAnXdXr4ghYTUML2OJ2gNvl1VPy9VauKZcq2d48YK596oHnSUdrFKHnQaoeW
         K0ng==
X-Forwarded-Encrypted: i=1; AJvYcCUZzYURubA9Kk9RgfqhQKlDTK6GpndbWJWLqp4NNH2tCVYZawe7OyFBsG/OK4ajSLu/3c4w/t23/V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZ0f15+7QxAIsougo+qWZ6eS8OdpFRoLQT7QPNdbMoEJ7LGgK
	sCZ0IoeYlwiUMQCIA6dgCGUMWwUn1wCjbx6tg/phiL4F0h3sFLFMLAHUrupZCFRONMsziNgI6Q0
	gWw==
X-Google-Smtp-Source: AGHT+IHlYdpWcZ5HY0d7QThx6RL7asrdrFjOAXqKmwBguteri+vuAFitGfArtl7cUClzhok1jWmoSWemXFI=
X-Received: from pja7.prod.google.com ([2002:a17:90b:5487:b0:2eb:12c1:bf8f])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2d0:b0:2ee:ee77:226d
 with SMTP id 98e67ed59e1d1-2f728dd330emr2928901a91.4.1736927411298; Tue, 14
 Jan 2025 23:50:11 -0800 (PST)
Date: Tue, 14 Jan 2025 23:50:07 -0800
In-Reply-To: <edd77011aafad4c0654358a26b4e538d0c5a321d.1736341506.git.karolina.stolarek@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <edd77011aafad4c0654358a26b4e538d0c5a321d.1736341506.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115075007.3517289-1-pandoh@google.com>
Subject: [PATCH RESEND 1/4] PCI/AER: Use the same log level for all messages
From: Jon Pan-Doh <pandoh@google.com>
To: karolina.stolarek@oracle.com
Cc: ben.fuller@oracle.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	martin.petersen@oracle.com, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 13:55:31 +0000
Karolina Stolarek <karolina.stolarek@oracle.com> wrote:
>
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>

Reviewed-by: Jon Pan-Doh <pandoh@google.com>

