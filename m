Return-Path: <linux-pci+bounces-8085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA338D5003
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEC41F23C17
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485FB22EF0;
	Thu, 30 May 2024 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RacPlRyd"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC12CCBE
	for <linux-pci@vger.kernel.org>; Thu, 30 May 2024 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087406; cv=none; b=ASJVIksrn3FxV28R8uc5DYlXBta42jduaX5bqJXy3MwHYrQ0EMvr0GGthMNV5159odrpFvQjuczEb5mvfyfsEw2JaRF/xCrKzd7mv6vJ6lHTFEGFvbwIYdFwSP57+nxDob8I+7rHpHZkSPeC/QgtorxWtqbqP+B+u2HNeR3syf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087406; c=relaxed/simple;
	bh=Dm0nVJ/NcIyMC9lntjlrCWDmfEEPLnVaRBi2b/vdQS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qENKZL30xdSD8naXfc4SCeb5sWLigsb0dVenRLLbWv/eSDAm/u0KH4D2kHSyMvf3sKiC/GIUyOkgK7OhOiOchyxlbOgAEy/8FldYZup4IYlB2C69Yfn4SHlkc0fihAPc9zO67EO9DxvIWZi6xtf7oFQce0WwU6kV/p6fV6Yu490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RacPlRyd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717087403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2j3l4Q70fl5RCpvAfo17nzmG43wS4MUrW4QcWGP7XTw=;
	b=RacPlRydB/drQZpscvMt7R5zEbAAsD8MfRrH/3rbFaArDiNx9dOKgRn/iweBalqQMEtW+J
	XqAVsN+YTFVI9ZSNfvglO/ujQqhxU0MzhQM7B60jDH+J6b+jcCFmL4f5ibZN32FDhojP0q
	9A0gcUWiv65SmLZYN4Ey3AvokEROecs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-6E7dVqBWNJ-IDeJ2LFVoHA-1; Thu, 30 May 2024 12:43:20 -0400
X-MC-Unique: 6E7dVqBWNJ-IDeJ2LFVoHA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35dc02b991eso711377f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 30 May 2024 09:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717087399; x=1717692199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j3l4Q70fl5RCpvAfo17nzmG43wS4MUrW4QcWGP7XTw=;
        b=pRLOdS9d/RuiS4hE/8tZ+utj+FixRcwIVrTJncGsW/CMn2VG5+BUZWmmM3iR5B5Y/h
         0enSOPhU4EYr0RhSqJQG4nD0K3s81PTA6kBpZBkSAdBQ2Qapo9DzAj+apSjQ4VlSpW+3
         7WuUopbXazum1jU23TaDFBWqGMQADc+UzvTxFdgeykVrJyEHb62rjtWKVy64nRYqt9ZO
         KcmjcdsHX0wjw04pESmTm3a81S7fa5QJWB0KlaAbkNGJebvdUIAR105f4m1wtsRmEBc+
         vD7SLrgTLm3tsknUfhZ2Gmw3FlJC3V1z5uqVF9SuFOBUbsUnQLLKyd7vv4hG/08gB+us
         riLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJPR6y5Fkd72cn2kCPkqTQjsuFkAyrR+xeAKvV/28xpN74C22pFM6HAtbZaOPxaBGQavdPDvnR5nlemUdO6Z95SWrpgjPyAZHs
X-Gm-Message-State: AOJu0YxvTUtlJDGsfHn5rRAJ925cSg+2isIsnKadzASJNifzmmDtJX7u
	oUJUXCqoWbxAb+z5Mt77QqfnnIIqVWJeFt6hjcOID6Y5JgfaSSY0glQZoehLGkmHOZkcN0d16FO
	TGxQFAi7xTnKDHPWmKFJRWUCiYc47tJte62Cum1nHLwhNBmKKIauy2tPhxQ==
X-Received: by 2002:a05:6000:1743:b0:357:9f3f:6f51 with SMTP id ffacd0b85a97d-35dc0091a8cmr1579822f8f.17.1717087399473;
        Thu, 30 May 2024 09:43:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhfBVZuT7T29BbiPidz23C2EktcMyt/erqpkRz8qyBYxVbr+W7bD02m2L0QdU5JckYeG3Apg==
X-Received: by 2002:a05:6000:1743:b0:357:9f3f:6f51 with SMTP id ffacd0b85a97d-35dc0091a8cmr1579810f8f.17.1717087399023;
        Thu, 30 May 2024 09:43:19 -0700 (PDT)
Received: from redhat.com ([176.12.190.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35aa9d22498sm8909179f8f.0.2024.05.30.09.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:43:18 -0700 (PDT)
Date: Thu, 30 May 2024 12:43:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shunsuke Mie <mie@igel.co.jp>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240530124132-mutt-send-email-mst@kernel.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516125913.GC11261@thinkpad>

On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wrote:
> We can fix the endpoint framework limitation, but the problem lies with some
> platforms where we cannot write to vendor capability registers and still have
> IOMMU.

What exactly do you mean? Why do you need to write to vendor capability
registers?

-- 
MST


