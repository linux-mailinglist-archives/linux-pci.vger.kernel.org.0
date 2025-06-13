Return-Path: <linux-pci+bounces-29777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 146D1AD963E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CBA189EE09
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 20:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440AB2472BD;
	Fri, 13 Jun 2025 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2MVHE/P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEBA231832;
	Fri, 13 Jun 2025 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846462; cv=none; b=BPh+JmuduttyT1aTf9GIxuc/cODf/QQITPyvtEAR2xTfAt/npP4rKe1zC7HeUvqzaI2qJly0DznMqVFfhOSckN4aVBwYjZ/6Mkjye1RwtwrnFvYGTZ185TRO1RFFT/c/8Pxm3F7B+yoWCpb8iXffpD4aWsFK+9RSJLQ4yUGJc8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846462; c=relaxed/simple;
	bh=MvVbIeVkQyVq6ubAPvymL2uqWzvSoJ/EGU7vFPZmAuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JG+pV7+SEKLn2ybdPDQUPOiu2fzGL1JxkJt58j+SFeq5sU13RTf4Y1OLkPIrtHwiIbEFnJzYzDdvD6+1mn+jTPiGhG/9b7Z17rncvc2AYtM9RepDuGifZf4OVjBNMCm9/kjAV4fDEaIB5xMb7KJMPJlXi6OdY80SL1lleQf1QdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2MVHE/P; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-313b6625cf1so2077966a91.0;
        Fri, 13 Jun 2025 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846460; x=1750451260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wuCVuGaHirlRuU3Mk+7drZzjFeMHQqUbXh9VX9SQqrk=;
        b=h2MVHE/PLIo0QfeqpyM6E4UiDDWH1DypzIhel5TL7I4KxLdE27xo2QOLyOLSH58zym
         5UyfCky0mYN5MFsfwiTYcy6kGpQmVD6iGdfdRK+3GiyccD+rod9KVfOU4wzgz9UTrcRM
         BFpg8Pt0LzPB4+tG7sdN2zHKgJdI/pQq8VfaHCkeDCt7JLZlI5H2RpOtARHFyjJSk+Dp
         rrzgQi3xL5x0H5j6Wjd8tc2NVaBHJ2H5iaV0WCH11C3bSVZkX9LHwC8tJmg0430TDwPo
         EZVMVP5Yh5CjNs6Iw47FGcIbR/9/xoZfGvjvk4TpZM27YJOQivtwKjA8YxYfe4W2rSsj
         Mmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846460; x=1750451260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuCVuGaHirlRuU3Mk+7drZzjFeMHQqUbXh9VX9SQqrk=;
        b=TF/9PnRSewLc8SOropVRh9A+0+MpT/GPjz2OxCf7q4HZoPZd/WraiCX4np4DOpyZk7
         ZWb8PLEVh9IdQkb5nGE1g7E+FwO9D4JNYc3M9luXALau43U2RmF3BavSsucvjRuHV5Q7
         Gb2tmXSoeNoAvlFL3hGdMHIan/8kj+yIOdy+Gh+VkGOurWKb/dnhDNVN/bjS5mDH1aUi
         ptvtfDoiaxb/oozEhfbONkIur/f9ekflSLEdW3Nfq0ssIprGFaAEwaum1h3wFDJcms9c
         kb93ey6f4Tera0yBkB690osu+GNwQPmbYjleNeS84hOq5KhK9EQLgUuuduigp8BozYFo
         mjwA==
X-Forwarded-Encrypted: i=1; AJvYcCUJv3EzFIr7dLANdEbkM3R+KZPcCvJEhvwFypYOcqg5S7Cm85lZtzLtwnm3vjBC61BAQD0rsbEcLjvE@vger.kernel.org, AJvYcCXB6Dl7fqFXDNBNni5JnzH+UObyE2n2lLddTkjeB058cBjwsZGhzNMrgp8ZUWWz+MfLnl0cxi87o2+elro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyPROb4g1v9qvHWVOGAbVeUDYYfmS3rhlVjUAoqhhxsXymOep
	JRw9y4r+PRUeDKiaIUx1vhhvMrym1l02Kz9wrrcuT4EmaKPubZMz51Sj
X-Gm-Gg: ASbGncsFNbrSsLt9VEs0cvRe7omlRR2TZkk3MY5aKpbyuAjXPjlWUtHAwd/5VH8nsv8
	iu+I7+E1ROzNa7V4Uhu4hx4V1SO6QSHHPMVkZAMdCbEYBY/ayZCpiCoqjatHkFIBNBREHVdMa1M
	odI4t9JybEk29ldAFf1WKozGWVeFnR/JJU/Chw3Xon1ry69lo7b1hhePGZpLzIGG/Ny9+OJaUD9
	6qq1Le+7RSy2FzO3PbpxElLrYrZGXw5qzujTIfjWc7Esp9q1LAImVwdfH0TODvE7RG7fhnf92/z
	zTDk8HL2gl4xWNqkU+7fkaUOfUzVLuOAXXJDoPsJxIT6k8MNLQ==
X-Google-Smtp-Source: AGHT+IGUQjIESVvCU1Q82nN2vM7R+sdaSyi8GkWTG/4Isa6h9OSBbLcr54ZlcJqq7Bpk+gJG6xIHOQ==
X-Received: by 2002:a17:90b:2313:b0:310:b602:bc52 with SMTP id 98e67ed59e1d1-313e9036e0emr2281470a91.2.1749846460111;
        Fri, 13 Jun 2025 13:27:40 -0700 (PDT)
Received: from geday ([2804:7f2:800b:84a2::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfc68c1sm18744625ad.238.2025.06.13.13.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 13:27:39 -0700 (PDT)
Date: Fri, 13 Jun 2025 17:27:33 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v4 3/5] PCI: rockchip: Set Target Link Speed
 before retraining
Message-ID: <aEyJtdhuofaUU-xL@geday>
References: <affaa12fedbb6e34696242d1f2f2dc5634b72005.1749827015.git.geraldogabriel@gmail.com>
 <20250613201543.GA974034@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613201543.GA974034@bhelgaas>

On Fri, Jun 13, 2025 at 03:15:43PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 13, 2025 at 12:06:00PM -0300, Geraldo Nascimento wrote:
> > Current code may fail Gen2 retraining if Target Link Speed
> > is set to 2.5 GT/s in Link Control and Status Register 2.
> > Set it to 5.0 GT/s accordingly.
> 
> Nit: I don't know what "Gen2" means (and the spec warns against
> assuming spec rev maps one-to-one to a speed), so try to use the
> actual speed instead of "GenX".

Ah, excellent catch. I'll make sure to adjust the commit message!

Geraldo Nascimento

> 
> Bjorn

