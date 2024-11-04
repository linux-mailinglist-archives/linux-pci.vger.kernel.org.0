Return-Path: <linux-pci+bounces-16007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3A9BC081
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F96282E41
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638921F584E;
	Mon,  4 Nov 2024 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwKhWa64"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B75516D30B
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757522; cv=none; b=CmJrsVH3Thx4N7ClOxrp0RjHaFdj/ML26Y+hnKmlZaCQKNXhObz1sp1KAx1TSv7hPlTQ+l5ngt0OJLOXfIXTPaF48fK6QJA7UgwHaFRcNglcOTgA3eZUhV9j13G3hTYOcZZQml+4dOlJTtkswyKsQPyA4F1bVQWKe4dXxrt7F4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757522; c=relaxed/simple;
	bh=N8VifZABe6KS2RvsBBMicx+l2D7SHbhzJkFkI7PQfKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEkJonBlNpHea7r54Ng5nG7Qs+jvDmcywcjY9PJRxiWhlq2yNdqU7XtfxhjbENRrH2SrIRZOJOhgZJVHJQPyS1wqXqVZVfQ34F7UkpWObKWRWaV6t2e9Br2VaRVDVS0o0zI4VWHh8gbvI9kQLaqrQpx/PaOJhj6MjS0czkKr27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwKhWa64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AC7C4CED1;
	Mon,  4 Nov 2024 21:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730757521;
	bh=N8VifZABe6KS2RvsBBMicx+l2D7SHbhzJkFkI7PQfKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwKhWa64toS4Hgdr26eCgPy+CBY2dK4uAcMGtCvRi3Xgl4piBHqmEE5yPa/y+zVhC
	 dK2ClaTSMbbdh0FR2UmfA4iUf3NNXTjZxSci/poQrnTbo/uy5NL82RT3TYX0MWHErN
	 OYKNEp5R8a98J2YwZpSNkL4Zjn4cd1x7rsWUxH5LmeJrAvEyewUGJG58tpMN7GnCW4
	 tnP4WzrD+F7qXBXodLvRM30SkB4Ml4MuYD5vMtrcpVWBLWwU+v8ZzHO0V4fQilXiR8
	 WccZq2VVV/EJtqXY3XBCjEaU+Yn0WW0U7pAR1eD8uHCgOjgIf98aAuCO8zd6CLUgxe
	 vq4/iiURPggkA==
Date: Mon, 4 Nov 2024 14:58:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kw@linux.com>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com,
	ameynarkhede03@gmail.com, raphael.norwitz@nutanix.com
Subject: Re: [PATCHv2 1/2] pci: provide bus reset attribute
Message-ID: <ZylDjhRsIeslNc5E@kbusch-mbp.dhcp.thefacebook.com>
References: <20241025222755.3756162-1-kbusch@meta.com>
 <Zyk8bvQZou-stmrW@kbusch-mbp.dhcp.thefacebook.com>
 <20241104215332.GA1268882@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104215332.GA1268882@rocinante>

On Tue, Nov 05, 2024 at 06:53:32AM +0900, Krzysztof Wilczy´nski wrote:
> Would you have anything against if we put this new bus reset sysfs object
> access behind the following test?
> 
>   if (!capable(CAP_SYS_ADMIN))
>   	return -EPERM;
> 
> This is irregardless of what the permissions on the sysfs objects from the
> DAC point of view are set to.
> 
> Checking CAP_SYS_ADMIN capability, to improve our default security stance,
> on a number of important sysfs objects (e.g., reset, remove, etc.) we have
> was something I discussed in the past with Bjorn, but never got around to
> sending a patch to add this check.
> 
> Thoughts?

Sure, I'm okay that. We are using DEVICE_ATTR_WO file attribute which
says should make it writable only by an admin, but totally fine with
adding this explicit check here too.

