Return-Path: <linux-pci+bounces-23255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB582A58802
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 20:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1447616AF03
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965521A44B;
	Sun,  9 Mar 2025 19:58:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D312153FE;
	Sun,  9 Mar 2025 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741550301; cv=none; b=DWowIkpZe9m0QFBeMdhQ4hW03PV+iNK3CYlQoVeAIVJaQmAyA3jxTQTNhuIBf2p4eVXh88SYBy0udqiUrqIJ81z7Xl7qRjB8mLdK5Mjc7YqcUNVmuz0+eP1Yjrsg53OEAgvVBASM8lSM7VdvzLK6bbvnpfV0S49n0nTrsuwfin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741550301; c=relaxed/simple;
	bh=aXzEzP4nvnAA1X6LEib1caGu5KzMtEqt5jFmUF4BA/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcO6PlfmSuzl/7Ftm0FFk1Jv34OY2618JOvQ3F8M5K7vYQYGSjLkJWrqGTHkXrAVsubXZHK5nlEtZ8xzm6qrE+HGewTcqNW/lp2hyGdqr0jBxHyy4uxLh9utrfnwtlTloUchNu32tbUSb9l4z3WtT2BZTWsD2t7uDZCxGSDBhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22548a28d0cso29306895ad.3;
        Sun, 09 Mar 2025 12:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741550299; x=1742155099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrW1K7Q/sHmi0cS97DO4Ujkj+4GSIS4/uU/BzaRl4ws=;
        b=SHWsH0EEhErumx2YDC438Ru6j0PlzyX36xg5ftn5uO0rE6vocUsmWEDhP2X+EhRUTm
         NgdamlGwGLz2wwsK35GgLKePjWpLGJYsepyFS2i0OY01L+o7pv2JfIcd7ZExmN9NF0GR
         409oQmvBhsq2Ke7Y6+bZ0GCMKN5rCZ3e6o92FDFTlxZhWXx+edtqNFR8UkeZWbqdoZb0
         6mb7V5nX42QmdhMZsDCgtBeUjpyZ/YwQbcCfrHJKKwF81+io+UW1OZf34waULibaWA5C
         ofRpUpt/BXb8gKd18X4qm5rvMGJwqLBqEwd7CrdtDpm5qSunglmm+TsKtkE614h/Y01I
         zZlw==
X-Forwarded-Encrypted: i=1; AJvYcCUl28bTwQhpK9zHv+U/o/j2S9xU/tmGNfbe14cmZXZ2t9zvy9AVfd8RVjD5ZUnGR3h4QoD5xuu/vLEj7H1XqcA=@vger.kernel.org, AJvYcCVcHbocQAiZFwGuUIRWxKbFZccHmFHcTO6I6uSWYNd10bpGpIUVsLq+dOtjHdfbrWDxeMu+emAQjwU4@vger.kernel.org, AJvYcCXCHgXGzc2ob/HXmpVPwbsbn5yDfm41gtRrqX4BE0bY1b9dA00HEXhHa1yD+j50LGu7GWG4xydOorN56IFP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoz6HGH5JOmFqrRyqckkjJVwezhUQUnotRm5fiIezf/2BILZAe
	EXZpUcRWVz4aEr3VpEtWWTwoQBgjE7F/um5aSAG80uiSXYz3WdRL
X-Gm-Gg: ASbGncsHbf+dkQxrc3Mu32DOWOsaNB8gbhQ/ScJjK79shXTM0MhirGAR+IxnA4Z3GNp
	Mb6kHeAbaelaHkts90I9/Q3E+I6krHjjFEfiQNzk6ognaeSq4zHMfxEoEvPiSO09NLmprKHzKJm
	Xtv/I+0B3YDmBqYUvg+HweHzWTjIU5h3gtMUVV1eXUPLY4E4hDqx+kRHaYC5qUgAv8u+fW7IVsu
	sQIbXNXtARi+2ZxJkjpWuZ3t5+ziioLcAHbaMRGaGQrkzJasPCSHXk4PlQ3ScdgNfnN7hSxW7bE
	tEN9jwXU7t6keV81LWsvNF2YI5K8eekVRSOUvaxY+Dvl697UWjzgkDyKF0FIf14yfOsPxy3dROJ
	hFeE=
X-Google-Smtp-Source: AGHT+IHyfPmNSOR8icPEXXCJvJSrjEib1yTDS++gcUqpBqBN55R3pRS/FHcInNEqgE9JyhndmxB58g==
X-Received: by 2002:a05:6a00:8b16:b0:736:ab21:8a69 with SMTP id d2e1a72fcca58-736ab218c97mr13280368b3a.0.1741550298881;
        Sun, 09 Mar 2025 12:58:18 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736ac1997c9sm5078881b3a.113.2025.03.09.12.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 12:58:18 -0700 (PDT)
Date: Mon, 10 Mar 2025 04:58:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jianguo Sun <sunjianguo1@huawei.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: histb: Fix an error handling path in
 histb_pcie_probe()
Message-ID: <20250309195817.GA3679091@rocinante>
References: <8301fc15cdea5d2dac21f57613e8e6922fb1ad95.1740854531.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8301fc15cdea5d2dac21f57613e8e6922fb1ad95.1740854531.git.christophe.jaillet@wanadoo.fr>

Hello,

> If an error occurs after a successful phy_init() call, then phy_exit()
> should be called.
> 
> Add the missing call, as already done in the remove function.

Applied to controller/histb, thank you!

	Krzysztof

