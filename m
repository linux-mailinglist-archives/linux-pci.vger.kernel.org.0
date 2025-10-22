Return-Path: <linux-pci+bounces-39056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41ABFDB7C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D90F4E1AFB
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D153F2BE638;
	Wed, 22 Oct 2025 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XFRZjc4d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7432E0400
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155620; cv=none; b=fSfvRe8+R9v4W3BWdgckczH8I9pQsW9//0OennuDBwOVOAHsRFLQ1kR3lb5UyKJidqXnFbnQcZ/EgUizTFwQRaCBfXVRObJyVJWHBX5uC06Su5mymmuP1dh66VFAwmQxJYJIzg1ZSC7aAuY5GqoBeG4mO2btzj2cO7lj+Z4rHfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155620; c=relaxed/simple;
	bh=pGtfMoapvO4lMb9UP8A/7JylUYzvwsLtdOLf+pqTo7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iubaLZCZkeeIscxU1O+YeR/MVXdnIDpqysdy12VWL5r4HnJcy688111E9bf4RbSLloRv5IqimC6//F2LySMkbOFG2y5vXCh8SQSNdVdZtv8qOQJf6/sUDnkEQYwHW4PevdpzGR72n5t33O0RWdLOyZAyPFGHjb133UL/2lzgee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XFRZjc4d; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88f79ae58d9so893124285a.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761155618; x=1761760418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGtfMoapvO4lMb9UP8A/7JylUYzvwsLtdOLf+pqTo7Q=;
        b=XFRZjc4dn1dqyWNIkWB8Tx1CrewYzSWip7C/wmjgHrr2R8/c9k+4iyaZhjPvIuw1SG
         ToVdoHWe5C7jmPhYVbrsBU7rORp/xhfzjJPFNgEMhpQM22ALzX0cSoUSTyTnl+2xfpwa
         1e+HpXUCn/E8+svkpZQpqoPC6oSLalFiAYug3BtbZLtyX5MnolRHRURjIHCuRZJECle9
         YEbLFupEy/F/F2bfcVMFZuAgF9113koiDU7PODAL7hjq+rHzXjeqhMvL4hIig3tG4SsN
         PFM4TlkoipPKjtLISb5rZMrzB5o2PVppJwh00wnrIw+S/uVMWJsNgjqvrNU7HFVXA1Op
         RUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155618; x=1761760418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGtfMoapvO4lMb9UP8A/7JylUYzvwsLtdOLf+pqTo7Q=;
        b=U0TXlJlYFzhtCQlkkCtEfvRkoeRRM0fok5GLIxhBezzSUEH5VT9U+TRPDG5yBsxcU3
         3J+b+bxVExAVqFLxjXphYQwo/xkt8tQ3WKjSelXC62dc8rGrLvBqQgYzTONf2KgDoyCs
         /FINTTZoTUsKcJzve4hbSR0qKqcuBjqJdTH7rO6eme8rF13e+dBwuHLj6+FrIm6ZhmKl
         prfDCOp3l0jQ4mBRyvwOW9mpu44u/kvR7vK4guxIZeUWVNrq5G08A9GBzvcVxN6BYFGL
         bdMpf69lTpzCZWZhrh+ml0KLiwpum6kfKM9srbABzOkk7tlQugvXpQudN75WAnf7TFVW
         Znsw==
X-Forwarded-Encrypted: i=1; AJvYcCU0InPcFMhYvuMCYNmcqislBuvRdfxXCSfhlRrSg+1gVXk3P+j8aw12RO3rR2HdoBl9RKpYMwu5yIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygNQDlYaNWJWQsyPTSPz6eznodT28N4rse93eZjTaKRuNfiKRo
	c3l0ebcyLEfsuZa9t0jzYZ5ueezZMY4u8Amkqz7r9EVqYHd5Z2RJfhhZE6dXvwqv8sc=
X-Gm-Gg: ASbGncslj8nDHlkwaRbOcYiY7SE5K1rAUyIDhBUs1DXWBlWAuoBPGLOkbMc/dDgYysu
	c07Te+LKYcRHz7ENjrbTInV8D8ddfZb5modG2RN+te1MKj9hZfoeh72pVRsJx0KTP6O0fUpCSqR
	JioGfy5Gu063kQuJspiHg3W/iAY2CCcpzsQdeOCchU8Ir7W2hkNXYywkhnI8Umrmwv+/OnccK7K
	EwBqpaTX9tnY3z6gAWX8ZMxntLryKH9iCEnmW9wRZvgZVcBP7xBCA/+D2Mcv1HUexOaXIGBI0n0
	bfRRaDZdBtK3k3CFoF4Dk9nhgD/qw2q3n5WuX5e8buRR88g99M2wYnpxawZ/PeftNhKY/llyc5Y
	oQ2i4j+NZkfEQ6rGBQZQxqoqnM+jTYVKqm5Tlj/LGJPJ9iw3a0P18qnr45QJjTjkVw4TXfk08Jz
	J365nnO/kGUd456BbJhX6YMbK5/mexe9dIqshUXj9E0hgucQ==
X-Google-Smtp-Source: AGHT+IESyeCC2FHKHN/7kLpkB57MVkKkUGNI8wUHjKLJgKkzjDVQUo6gHR7luBSwV2cWSylpPLwNZA==
X-Received: by 2002:a05:620a:172c:b0:891:c59a:a9c1 with SMTP id af79cd13be357-891c59aad1emr2195885285a.39.1761155617879;
        Wed, 22 Oct 2025 10:53:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cfa623d0sm1012199885a.60.2025.10.22.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:53:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vBd1j-00000002rQd-39Fm;
	Wed, 22 Oct 2025 14:53:35 -0300
Date: Wed, 22 Oct 2025 14:53:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vipin Sharma <vipinsh@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com,
	dmatlack@google.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <20251022175335.GF21554@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
 <20251018223620.GD1034710.vipinsh@google.com>
 <20251018231126.GS3938986@ziepe.ca>
 <20251020234934.GB648579.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020234934.GB648579.vipinsh@google.com>

On Mon, Oct 20, 2025 at 04:49:34PM -0700, Vipin Sharma wrote:

> May be serialization and deserialization logic can be put in PCI and
> that way it can stay in PCI?

This does seem better

vfio should call something and get back a token it can store.

Jason

