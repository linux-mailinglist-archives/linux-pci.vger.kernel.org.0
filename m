Return-Path: <linux-pci+bounces-20877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0663A2BFD0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B3916832E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042211DE8A6;
	Fri,  7 Feb 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="I+eU5nPo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C041D7E21;
	Fri,  7 Feb 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921546; cv=none; b=GRIUe/KJuPcpqgsennmhnv+fVHJ6q4nj1QNt0XWXjgVZO4wfD32aKbbc1baQfkIYL2OqTHRyBJWyqzEGBFLwolzetrWd+y/fgDvsI1Zl19bCDrdKauhhOl5Z1NUMILs7A9vNzqE132NqCwKGu079ZRmHe6n0hZ8i/JMyJU+m7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921546; c=relaxed/simple;
	bh=EtiEn7NHh3nbo00IjjxVgadUdQcYzfcZj0lYUhwK4iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOto9cjWfpnEZotqhejpuITkYJphxSKG+YRqRCEQqzBVDfKFrCozlj7v38GfGSa15Cr8ktm4SYu3t7PGIa/okQV7jycYl7Ca9Elafy/I8dYekgEXKv85nbLxVOEhOMkr4aSABZ2L2sdxjJgWX1F3JjM8jpaJ9OXdEZzLwqPhv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=I+eU5nPo; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738921518; x=1739526318; i=markus.elfring@web.de;
	bh=EtiEn7NHh3nbo00IjjxVgadUdQcYzfcZj0lYUhwK4iE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I+eU5nPocV2Z+aRnkdr0njmJa4XhMrwZxi+Abw2vkZRwx8UKMYp7GEv+42jk7+ZO
	 bkL1IPwMz3gHfLx5xHtq+hyfblq8mln5iiSOhWsx7Eu71rC+ldlGvlZxZAklBDLEI
	 2fe7eEiesAMWShxO0tPS3AWlvzUvb3Vrh/xyxhjrFo130yGlbSjFbTmMd2K233ZSF
	 bnSMEF0yvZATeUfytCdGWYPfNBgn1HI0jiJLb8y9E/3dAey6YNJq3fYw6v5EQEg0M
	 tv5vxr5GgTq9FHafLK4K83pMFpl9bIFRl53CjVGmfpaqHcjc7OtfQpcdMHpy42+Zq
	 F8PpMtFD8qgqr3SP5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.29]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mo6Jl-1t56M10XoR-00eaQC; Fri, 07
 Feb 2025 10:45:18 +0100
Message-ID: <2f8cec76-c882-4f48-8345-d03fb09404c1@web.de>
Date: Fri, 7 Feb 2025 10:45:14 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 devicetree@vger.kernel.org, Bharat Kumar Gogada
 <bharat.kumar.gogada@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84s?=
 =?UTF-8?Q?ki?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peter Zijlstra <peterz@infradead.org>,
 Rob Herring <robh@kernel.org>
References: <20250207065925.6u7bemyn2aireiii@thinkpad>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250207065925.6u7bemyn2aireiii@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XpeVuxEZzZPZKVrplBoSdaZIWts8OscNE8mi4ye49l0yNVNMzPK
 ikYoI468e5S8HbI3eQER1Eqk551Ex5/u/4A1taKF8qg8ICTxQH3kEeOc5ubnLmHXLkPVUnB
 PPVF0f6FYQrCQnWg2QCrVgUDtYgqorENvBSUUasSsSq7XU3Rd/r4Baa/3dlxBDvI8YJdeN+
 ICJ3p8tRXTMxAqK5uhJDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R2NmjkEBWHE=;yBCi1rHnyYuPNimhd8q9wyKO89+
 zHnO8ztuQvNXvxvRhyMgZpRg1jY9SDkGA8M60DlSNdlhfgBbpSe9n7jSyaEFkEYX43S0bIbUg
 AoB7+/JVrMINBx0W69rWNKT7F38CbseiNJ0R5ZScOE0GEeqfGO0a30T8eFpVQs9y73c68evaP
 3lF261L46kjEIrb0qETdKb0EBxFMaGq5ov7pq1ulR7rGp787pUzvl/TMhcatOGTqfL2VONxQj
 rCRIsUc2Q3mZ0e/47m/vlONdGX1TFw2tS6rX2uT/EuhLASHU9pvxytTM2mxbPxEUa9tftzqq1
 qOCPGeAEsTo389vJrf99yP0u8TerISgmr/NwthJ3fsC9lEb3EwehXMVjxWiLBLjF6tcqUo/2j
 s0JFbI2KeHkEEJItElrCDMCYC60cGYcoo1AIRRdIHM/+wyi+FTJFdVR+/IxZbTLcLG8/paZdI
 GsttAKZUAi7zTm4PxTfKwUE4nMAJHgUxACtgLOzh3okZMqO51cxG0NcnNiKGGfBHNXWmw26HE
 HldaKvbregZfxU/7Y7txCeyyT/4NIwEVP1m8siy50W+KwSzBtr0jIyaGcBzpFeKgpHvepAwCp
 xNsGo1oFiKZSLWJM0IFiyQthTRSYAR6c4roNEDokUBldzhZtkYOJBUIfdkW2mRvFLuwj2y4//
 UmDI8xJP0EZDkMT6gZHCTG7JO90mSt3/2F9zdlLq48i4URDxVL0NJeb3kUveizE+gATRB9Eoa
 1dYAJwS+ZBmQpM3nyAnQ5mAYqB/3MWW+nR53WYsH31gv1ibfepNpJ8dYqvj44cl89HGLNTeQb
 cq2SPovzNlUoCSYH+Ys9xb27lJHM9P+gpQ31BxUoplX4fku8BGGiWfx2/iBDmuo8fkdQ4fdwm
 SOSvlCnryKZKRt4zJdTQkb++Zra4ud+9S1Qm1RUsbc6rB0cR4lnI6k9usCl4qn1VW7WrKc9Yz
 X2+JG4S6AHEQQN5KL3KiseoyG2mqQ6mFWXrPAnWsHbh8qlc+fkLvgmQDjn5YQ/3YUL7hjVVWT
 5AEomn6nkRxtSm1gXSIdpO9P/+kN6D0kcKA0Lkc4AsIdDWQR+ovJYwouh5uGyz4zq4Fy9AmUE
 wGk9FBI6yHN+AX59yg9YwfvnxWfYETOVoK9PfEDK2qiCzpb3e3IXZvjDPI6nSCfhierDhDHqh
 wLhQIawEl1J9DeLsZojY7vbnRmsRL3h7DK0lvlhc89m9J6bcdx3RV+kAmDM2ZWq8EGVEeBtmU
 B2O3cBY9j61hWcp7XPA05l1fT0r15mM/2mU0DQow04NiIxXY2PCPKoUYAPYE7KIK0ri98D/1K
 CKpEFN0Y0rt4485/drYglAcED2qHKOe0LbaKjHVJN+bR+ksASsRYYeEy+SiLwV1EAysRiyiZd
 gddSf1bPJSUi39UwVE5VsYuy2bknMx6xpADmLAnmDo+zD+XdVrWs6KBfzFa804jQFhspAJuXe
 W1kuO3/C44JVL8ry8dIJIWZBQmVU=

> Please ignore the comments from Markus.
I hope that patch review and software development discussions can become more constructive again
also for related topics.

Regards,
Markus

