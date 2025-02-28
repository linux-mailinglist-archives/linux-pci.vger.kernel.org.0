Return-Path: <linux-pci+bounces-22639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28DFA498B9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 13:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285A43BC12B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 12:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8419E26AA83;
	Fri, 28 Feb 2025 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coldcon.co.za header.i=@coldcon.co.za header.b="iQxqO7dN"
X-Original-To: linux-pci@vger.kernel.org
Received: from outgoing61.jnb.host-h.net (outgoing61.jnb.host-h.net [156.38.154.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324525DD1F
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.38.154.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744157; cv=none; b=MPVen63yYLTLzquClsl+s/7zF3P/RLZvvX+OktmGpazudvX8KPujEZEwJqslmysFQKYoNwgZJ3KWzLAxR8PdcvWRjhsJinztvw6jA+mx446Zat4TxI0CORZgI1W+8uPK6nTekXEPPZIJqDHhGW+WdPWvlbBVp/d/iWEA6RALMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744157; c=relaxed/simple;
	bh=LnJAb5OtSiiPPpVmdSEicOxdfy335XXtHun9Lv2d8Bw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pnaewd+gJjJEVHKYyjjnmLzBMgePVMUsmkjL4kQjM/QwVQq6NGe+/4WtpoSHCO1Jwfl7/QYeQXfbRXLzwrIPyCY0SVSf5SAFBRtgHdAOSxBMEaxuoCIuHHfPw9xp6nYBV5ylo9NnAt6rVJKEJG70b4zgsiJFbzPSqAz/W5wL3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coldcon.co.za; spf=fail smtp.mailfrom=coldcon.co.za; dkim=pass (2048-bit key) header.d=coldcon.co.za header.i=@coldcon.co.za header.b=iQxqO7dN; arc=none smtp.client-ip=156.38.154.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coldcon.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=coldcon.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=coldcon.co.za; s=xneelo; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:sender:cc:bcc:
	in-reply-to:references; bh=t+qwmUT3iOAm1DfPM+nbVN5TXLHXkSwi3Xte37fm8Y0=; b=iQ
	xqO7dNhxtjSALYvawjTa7zs+KT7DUWs9arYOBfuXR4foEBO9JiJZLarU2PTPfOoQ/TA1i6orj8qba
	WjJ5KodomVG+b/Awi8jWviTLi0MWO09JEG+Aszt9uhBNxfZi51oy8ap2zlcDaUBaGBfZY9/HrS5xD
	+iWr2Qfp4a6lF7db0wwjgdEoeHx3rqG1gONxf2OiSd9RoFN26GykdJv76Vw8Ga1veFIP1rAWLyhgH
	UdwshwLHZypzK7EPafXQMYEmg0/HfOblciQpix4JRsuo65B7YhLcT0rcMujE1i8+ehHnquUPpoShi
	5QUyD9QitpxNniM3QVmeZ6lvlGRq8bjw==;
Received: from dedi166.jnb2.host-h.net ([41.203.16.166])
	by antispam11-jnb1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <avaril@coldcon.co.za>)
	id 1tnz4Z-00Cdtu-4h
	for linux-pci@vger.kernel.org; Fri, 28 Feb 2025 14:02:32 +0200
Received: from [104.192.5.240] (helo=coldcon.co.za)
	by dedi166.jnb2.host-h.net with esmtpsa (TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <avaril@coldcon.co.za>)
	id 1tnz4Y-00000006OeW-0qhP
	for linux-pci@vger.kernel.org;
	Fri, 28 Feb 2025 14:02:30 +0200
Reply-To: funding@investorstrustco.net
From: Iyke Nikolas <avaril@coldcon.co.za>
To: linux-pci@vger.kernel.org
Subject: Re: The Business Loan/financing.
Date: 28 Feb 2025 12:02:29 +0000
Message-ID: <20250228112431.01D4B73F2B674DAE@coldcon.co.za>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: avaril@coldcon.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: coldcon.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@coldcon.co.za
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.88)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+CzanhUpQxxY0jGcn2Rs0cPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5zfDbEg8I9EPx3YIexT8zdrU2Itm39BdCc4FEP6OrUewhPm
 p87GC1OZvsh7yKER8spLDLhsmUKXOrwXN17G4t01eb4o0/MLsfRXq2B6Bj1eqIhJNeUYrwmMRp0o
 fTv2z6OWrRCR/TGJ+LxBEbBCS4VQbvH/y4TBKwDHfQa0wCenXC+SjAMhlxVTUP8RXDYi0U2QMspg
 Ao/30hhQ0kI+rmTqWvk8msvDI47ForX5GWA+n8k2UIHTjO0tKRhzCIXD0CZh8eXuGDB+WvlcaPhs
 +IMOUdShXBqjIqKx5jnB7z3Yhhp3eWzGQOuNjEBo/WEbPRDIZwKDK1Qy7Yn0clcDVSjgtbaLfdxI
 2xBN3cmR7dNBzLm8D0lCIgUANkVen5FLPBiV/c7g31viaan27/VsoWnQPP2nZVsMwXoTZLRadQLt
 9HGlfXdmgJrKjBlTpWs78y8XcyZ/7+cSpFkndHGnqif7SugB+UXSiJRAsNSvmUSSESCv9TR+UxzL
 ZWL8hwGBjhoiDZaHjjUjL+gPrBh/8n4kpYzALSfDrtQHo6yRgtyrJfVAoUtwvTBLoObUYKePXROK
 McVN5dAS1WAd0WlK2g33ZTmDiuInTF1nn44FsG7IfwMBWGuashmM3iT+4GxdpueKHYcWWwiikDEw
 0L2tQ2Vz7QgdxtQsKWiN2eBEpDFg1VMP6t5qUNbkx/duvBFFEDWrf6mhLAJyf5HFv/CNAtfcbkrr
 XJdjvnK1Pf/En0f/a5D+j75TeV0Orz45NCh+pBs6XIIIG8Q1BfsvHne5YcnRHfu8OQBn2E0GRi6C
 /N93Fal2rFu1wGqOfBufyw6YYHv1H/aAwarQpYDOYx/6JtUOePZJ1cLZcEz60L2+P1AbxHnFclhU
 Tx8cSXpvegfDpRm2UYC3nHd+F0bSxeRmZK2YK48zBUFiTBZlsVonx1/dsKYqMqJhMK7zo5npQAo6
 6E7yKxL56TB3QjzBRZUNmuZa
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net

Hello,

Do you require capital financing or low interest loans to advance=20
your business projects or growth strategy? We can provide with=20
the needed investments for your business. 

Get back to me if interested?

Best regards,


Iyke Nikolas
Managing Partner
Investors Trust

