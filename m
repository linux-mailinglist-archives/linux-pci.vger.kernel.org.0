Return-Path: <linux-pci+bounces-28444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13228AC49E8
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 10:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89A0179BE5
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 08:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8D6154457;
	Tue, 27 May 2025 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GgBoDvea"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A91E2307
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333368; cv=none; b=IYSQR0/tknMVorMK64Ug0qiwbzo3+ws60zvHJB3EiVhhXhGM64bWWdH/DGjaMvVEZoJ1NMNpDVcDas6G+Aru2b0tpOpz4l/eyirHcSbJyQxq8aoQ1wqv6iko1oscRhUmtU4/7MAb6JcU/VfA9Ntbh2nPqptTHrvbgen22RpPv9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333368; c=relaxed/simple;
	bh=g+elwpFcQLRrL1yA18ydtpjh4XYvoBD6U7pBhL+ChJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBcHV5Mf3norJ4NsROKRbrHy9Xs1yxQu8rMmnHZ/cOf5TB4GMdJ3YGMUCJPfwQRsCgMf4AoSFoNAqGhHLmGaD9UH65dxJAcsbEscJm8aqXlC+cZi6n3i08SKNja3VJP3m/nUrTlfS/HDCOc35lwB6nmHYMufaP1v+wqdvwyNb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GgBoDvea; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CtwfCTcNAFoxiHeZ8MrHZKaw0Zaw9YfW2ffntciMmio=; b=GgBoDvea7xXmJeJygHnFpt99Qh
	++4BoFE1y4SgCKg2aE9C/7Y5kRmJ4UTcvbk/oaUbwTvWcMIQDL5CSjm0XoqrVTIO+FEFy29N1H8xN
	17SnDlTXIEXw3TfSvxKIRNNfIgHfMbvAst+1oFzrslBPt/A2+bd2fzCro19lt6Yo6Z0J9T1BuYeJp
	+tPqmTlNPMaRadKXKCz+OaX225x2m0vHISUom7wR1tOOalZn9RzeqKAm7loNT6vHqt6VW+C/zEeWR
	sgR194wrzDakY9ofxHjDZgtsl7DeWX0PkTL1gpA+9Q1JEgKI7EBfbrguEJWdVROAo1uSZuJBLf0IN
	+UUPt1wQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJpNA-0000000ADa0-1iRB;
	Tue, 27 May 2025 08:09:20 +0000
Date: Tue, 27 May 2025 01:09:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hans Zhang <hans.zhang@cixtech.com>
Cc: Samiksha Garg <samikshagarg@google.com>,
	Hans Zhang <18255117159@163.com>, jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org, ajayagarwal@google.com,
	maurora@google.com, linux-pci@vger.kernel.org,
	manugautam@google.com
Subject: Re: [PATCH] PCI: dwc: EXPORT dw_pcie_allocate_domains
Message-ID: <aDVzMIJ-jYwm2QWZ@infradead.org>
References: <20250526104241.1676625-1-samikshagarg@google.com>
 <39743267-6a2c-4a5a-9581-05b03e25477f@163.com>
 <aDVCronBm32GwF77@google.com>
 <9c52c87c-236b-4e8b-b40f-92d5f39f944d@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c52c87c-236b-4e8b-b40f-92d5f39f944d@cixtech.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 27, 2025 at 01:49:57PM +0800, Hans Zhang wrote:
> I have also encountered this kind of problem of yours. Actually, I think the
> dwc driver should be compiled as a module so that many SOC manufacturers can
> modify it by themselves. Otherwise, for example, Android GKI cannot meet the
> requirements. My previous approach was to copy the entire dwc driver and
> rename all the functions. Finally, it is loaded in the form of ko.

Adnroid folks just need to upstream their bloody drivers instead of all
this crap.  And if they don't it is none of our business.


