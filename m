Return-Path: <linux-pci+bounces-34437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7C8B2EF81
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 09:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5C85C5A5B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 07:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214AA2E7F03;
	Thu, 21 Aug 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXOFLCnW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F066B27B352
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760969; cv=none; b=pY1ryTwaKIFIEXw0qBOXK6BYhvZyMUnz42pR7TBkQtZfGSGJ1huiEDfA9XVuASkyCHj5+eU79tZCUHQ+wXBtMcsdhNs1tQBfHHO0pWRcXhlucAoTbIPOq2bvyzYQTyTUfgXulnV63ayI806abymNeF7xkwCcUwO1bs790cKxV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760969; c=relaxed/simple;
	bh=IlbslQg9ypl7nnBSnyXkKjmz1FjNd56l9EY/OV7b8ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDNyMSnrB/wsC9MWKBFPE54GFqpfXCE/0AT45P3a9Dr0oRrLTtmXwajYJX0GdJsLjYMcODvPqX48PyTdGXyvMyPJuzoRVKI0z1giWypa+C+3rUP5h80uTeV3L18cVsbrgcFNGhOUrdbNKylGpen2RMCQmnGzbkegdgkoU6z5HrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXOFLCnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62019C4CEED;
	Thu, 21 Aug 2025 07:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755760968;
	bh=IlbslQg9ypl7nnBSnyXkKjmz1FjNd56l9EY/OV7b8ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXOFLCnWjDf2rxAIgnEGfH+K2UfbL4xNm9YIjKxV5m76C+UDekvoh3j0rXR9DYAx6
	 ZYzP6xSFCCLEjqNIOD1i3BcBLGitp+N21LzxlSOAJNHDKlQ/TCr6pPdzKp6oE5Mehx
	 fl8uQ4BTB4GZAcbLCzwlmrmOaHvhBmH2qgkJxe+8JQd0S6r01uGS38xzCEWLrIQtWe
	 DrywBR4g6re8eA8njqtYQpIT8xoE0wW509/0uvJdAQZGQra1WwTDJpsWdG5LR3EcaH
	 c9Fg3VX2bGvx4l+JglzntA/en4SioMZz6gs7DSUSN9LPh6oq+BeUeka8qFwka8a+Dx
	 R57x/KcUV0THQ==
Date: Thu, 21 Aug 2025 09:22:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v5 0/2] Configure root port MPS during host probing
Message-ID: <aKbJRIgvO9vtXsvz@ryzen>
References: <20250620155507.1022099-1-18255117159@163.com>
 <aHdXwr-UZz6jZX3f@ryzen>
 <aJyILhOnXDJB4GgD@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJyILhOnXDJB4GgD@ryzen>

Hello Bjorn,


is there anything missing for this series to get picked up?


Kind regards,
Niklas

