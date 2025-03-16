Return-Path: <linux-pci+bounces-23888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11855A63584
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 12:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE0816E612
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D071A2381;
	Sun, 16 Mar 2025 11:57:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE028156C79;
	Sun, 16 Mar 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742126251; cv=none; b=qVxWL8uA7uHDbEx57A2KBeGyI9rih+Kk4QokkGAJ+goLztnIcuQLz2B/wRIbKv687+/Xc7aMXsSGu1w7/xl/l4xRt3Q/SvVQEAUbk2UoUs+mr6stAZt1fMa/YC28WL12hpmzz6FMsfg1IGcqHAscdofF8m0+VPECwajB8iDKAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742126251; c=relaxed/simple;
	bh=2WF/LbKitrWCBqXXi1nhQ7fkqFR9nNo/2lMHL7NRV5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3Li7JusO9Na0aiVbSF+iBxTJXNb5ImIeqzyLeXutrZcsUWVA6/JQz0gXwG1aLBXyqSHKwFk+bCyvR3N/z/5Gp1I4wiQTxKMsJ1h/MqgXo+p7OWz0tV3jWk1Ydcey5m5V5PeA62gUeKlB5/sFFDYVmwSW5oSMi6vaBKKVBFLeBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2254e0b4b79so83761285ad.2;
        Sun, 16 Mar 2025 04:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742126249; x=1742731049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5ZPUuGLWzPE3DEGuxQdFm1d6rNLeHLFFd3OHs6+QQU=;
        b=UCA+cZVs/MuzuCgHR8xyoA/JTmFN/qDVrSQd/H9DeQG4UOhyrdQ9XLgSr+innv14zE
         uBghM5dDuEZaxC117ad7+KIV0JZqP6MnFq/WvLO4d+9cDP5Mc3UxURomf0GwhDwgoWPS
         KsPCu7cE3ZYSGdJ3G7Z64FtLTSBo8bvVEhKAi2Xfhiw8mN2oqQ4pQNxpxvQyA5dDnr3D
         nrnPMqXy2W0ByFUsCOo9qWaM0+ZWsyxXxLwsqMrRM0fAo20mAX0ITBuLLfO5N4AvH/as
         giMPzXA7/d/XkU/hh6SvJoU2rR6OEvU45OpEWJq83GJGhESJw8RHcU0gJMlatGeU3IBV
         hWvA==
X-Forwarded-Encrypted: i=1; AJvYcCUsLDN3XCR2OxbLFilXUDR/pg/4YvEflqtP9uppBvm0aZANO7vz5vpdtrMyh+ACwuAwWTfhxODN3HV+AMbk@vger.kernel.org, AJvYcCVY1O1e/7JS8RbDf8u7LSYS1BOwRE94OENjwUbkKuBL+2P/WPaaAA0Zg8Ij40+/12hYn4dd0EnvfGT1iSPON7U=@vger.kernel.org, AJvYcCXVm3+fCHEaVeCjRTIxW0pH/8Q3NqFy0FZUWlsfe7pw4DsjITxbUnGh8oOx0lEuM2A/49oAeJol/YXr@vger.kernel.org
X-Gm-Message-State: AOJu0YzP6fGcogcvuI7skBQn4MuyfafonQTd3ckH2pOQHv2sDbM2TTt1
	rv9MsePr82jSvrWSOXqRjjChfCWkbeDVZA0V6vSIGp6vg5Ic7VBL
X-Gm-Gg: ASbGncsPmIZvs0XN1WuuLW93w0RzfxvPLI6PpIa61jooob0mG5Pi4MFtAA5mMFGKlRN
	scBNMK7FWhJr76Ik04DJg6yIZaJ5IUCDNiaubUot1Y0R+WTOsvDdFuoSX1cs7NIC4XmqDWax1vS
	i2/D442jD5OBzyVoK3oN1/AGnKWR02j53eQoVqTeKf8vJesGIQNX3BxUqdX+K61b3hTnAlbfxDk
	PgUMLmiwwv1s+xvyIUB35iilN625mlmvtpNxFpBLJDNKUzMlBNIfhsEvARJ0FcdByp8nn7YmGAJ
	x9aAMNiKhxSPosy2yOFRbBveToGGCY6Cj3UOWvdesCAt4dn35cJC/n8UoY/ZL7hgeepVu2abfoo
	jCoo=
X-Google-Smtp-Source: AGHT+IEQUgd9b03NsYUaj6vePK7+aFkFyLwaesjtcXEgi2/cqXOUtR6mlOUWm/CB/nd0+pkmYkP/oQ==
X-Received: by 2002:a17:903:2391:b0:223:619e:71da with SMTP id d9443c01a7336-225e0b23b6dmr122934195ad.49.1742126248842;
        Sun, 16 Mar 2025 04:57:28 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c68883adsm56844685ad.47.2025.03.16.04.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 04:57:28 -0700 (PDT)
Date: Sun, 16 Mar 2025 20:57:26 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: histb: Remove an unneeded NULL test in
 histb_pcie_remove()
Message-ID: <20250316115726.GA3021602@rocinante>
References: <c369b5d25e17a44984ae5a889ccc28a59a0737f7.1742058005.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c369b5d25e17a44984ae5a889ccc28a59a0737f7.1742058005.git.christophe.jaillet@wanadoo.fr>

Hello,

> phy_exit() handles NULL as a parameter, so there is no need for an extra
> test.
> This makes the code consistent with the error handling path of the probe.

Thank you for the due diligence here!  Much appreciated.

I squashed this patch against the changes already on the branch.

Thank you!

	Krzysztof

