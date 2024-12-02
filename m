Return-Path: <linux-pci+bounces-17556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EFA9E0C51
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 20:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B400D1654C1
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 19:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692E1DED5B;
	Mon,  2 Dec 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="sHiO1QK6"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36911DE8A7;
	Mon,  2 Dec 2024 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168380; cv=none; b=d2nE5BzPzFDdJAsqu3pTPiTwMnZ+REUV4iljaGKQrs2lYrqGEm0UQFb5pdmHATVM04dckO+MwqiAR7d8xm0jgsPsvrewLSbzSlVCLNU9r9HwqXvNMZt4Op6ZdptoG/Rcnrq7Od/svLmkobE4qP6j7TUHIJBic2V4pecoNWbpMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168380; c=relaxed/simple;
	bh=sN+BusGiAXrcqhWl1VTOqKR/W6+1lgZS845M6w7upCw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=RaZjTDmfHw6aWAjhLmoo/8zcDN2uljkmn+80KDfGcFPjxyaZ/9rRbVGLDByq0GSQndEuJQ5bRT8sqfq9iZMDxb+o8KdykTxu4giP+wPvkGEGCOs22ID78RRtyD8F9XyFswzrRoQl4hCexkmrRD2MpCt4G0lN0a/c1sV70QVucj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=sHiO1QK6; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=tckQN36YPgB8u8XCuGTMiAPwciU1S6zlefvWMXkUjgs=; b=sHiO1QK6zN9pjOhhlylsZYFDkU
	EE+a8JKnuXu8gVlewZy35dnckWr61e3jScDXWwGbHAtwg4VP7MrsaRvoiw6FDxhsaQZNxQOZYoYap
	HY6k2gaYGwwHTRenjkeOqtSmWp8z67Kn79G8fDxaJbdzjIiuWb/Lx+sN8qjnhkz3K3AB5Dmj8laC4
	6itUtLoOZ8l62AM+BuhzdfJWfzgqC7Ni42WtAr9EjRHLHtq6O80B5RF9hF+gvPbhtX6JRVrPKbn5/
	NqUnjJbCEIi4o7YpZyqA2k2sbyWz9bK9zj/7sK8NdUIZjcuGXaM/t3MnD3wsUonSFv7rndhPWuGQ8
	scznTSag==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1tIBlh-005alK-0z;
	Mon, 02 Dec 2024 12:07:36 -0700
Message-ID: <003d2d13-13be-4f05-80f8-61e14ddb9c83@deltatee.com>
Date: Mon, 2 Dec 2024 12:07:34 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>
 <20241202-sysfs-const-bin_attr-pci-v1-3-c32360f495a7@weissschuh.net>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20241202-sysfs-const-bin_attr-pci-v1-3-c32360f495a7@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: linux@weissschuh.net, bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 3/4] PCI/P2PDMA: Constify 'struct bin_attribute'
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2024-12-02 12:02, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Looks good to me, thanks!

Logan Gunthorpe <logang@deltatee.com>


