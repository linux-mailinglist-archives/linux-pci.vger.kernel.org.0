Return-Path: <linux-pci+bounces-24463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C9EA6CF83
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 14:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A7F1895ADC
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF32111;
	Sun, 23 Mar 2025 13:39:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF917E
	for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742737164; cv=none; b=AV2wGgkfV+K4v081kqdXilLlR0wutAZl3r9SAolcfcqPwdjwarnEXgYkj7P6+3L9MA35muU7InrwAcYL/R8l348w+D8D8UrOeVxw0LDQMW6vasktYB57EnEY5aDUKLdj+zFpkt2NE/XDeTXcMmSvDecl78GNFU8qb28nkxTnHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742737164; c=relaxed/simple;
	bh=dwl6QtpIFF9fEzrtbURsue9BYcKSm1pyTzJKp6nt7zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDBBjgbJSRt6a74TorsDcwoYCUM5E9ZMkGnx3DVO7oyMY1d2yvcQkdb4W3fLrRBlTC/PsuOerzPvm0eHiNRaYLcEqkYnM7tPfQED94tXCC6k7JlSNyUSVWgDMC+FrBvZki/PIfHTZvRLYRIEFgoU7xpw/RqIf+6/QO4j3ACIzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-226185948ffso66376175ad.0
        for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2025 06:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742737163; x=1743341963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LirhhL1Oqoa8Y4yqLeQAbBfVqgZMoZx9ZgYet4tucO8=;
        b=ujo0wTJ+qBJ+1mcThh5gYKpeIZafAzod529obcK06AYLH1ElUGJxWhEsAcLnjRP9qV
         oT0zK175fXso2ZNPlMzTRO84ZOw6+7y989JOc66HJty4bRykfYt2M0reOiDk8FZ1iWN0
         S+Vs3TT8GkeHFdANTPeE8Os8ICyuunHb0S9rS3QfrXeOTvfOtbPO3DnwO3udyUicd//8
         xKF5mSy2oB9TybI4VvTBDsA0YH/wtgGLLoTXFpUcS6EhdUpiJ43eXzyFFfBD3lvyfPYo
         7HD1KTvBrzxjAUV0CDHyukulYwc/dEI6DT9OGnc/yyjX16AgLISmTKK20UL3y3sx34Jb
         q7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPC2NBrBmvD39eXbm3vQ8U0OhhVhDavTttDvfUsBH9fmWIHKTOM0JRWSqldStSoSXtANf8WHHaSZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cDMFJV5TReZqxXyY2Bt09Bq8KlzD60L8DIyYudmc37nLgfwq
	MACps7MO4MseQic6CQyQaPoNx4MI+022RZlLGyCBdEvTyFHSTJSf
X-Gm-Gg: ASbGncv1TEq+Igt7244p0EkWSLeAj94L75zX9IsP8Cg0IEDL3Q+aUVu4tIoyZ22LxB+
	au7gX33U6a2jubg4K9k/EtWq2VJwlvGDWAATNxHkPqymhDQijNvlaoTcEMuRzM2NtmeCCl883S9
	vs2wjrE26OJPIHWkwNIJot2hUWx61tut/D9q3FjrMIjiipXL5ukQb73joN5D2s5p26QQOLqaFgU
	m8Gb9FbuRQ2x5t7wHKKvtgYc3HkiYfjGHwhr6HITKH+BUXNI6y0ijjNKSIxnIxiFuQXLFMHD41U
	tO8JkBQEcim/HDYc0E/7s3vFsZz2iMN9CcQSaYoJG5jhJ0vjhM5Nwf404ta3KwtyUxpOcHlNNtK
	/UCE=
X-Google-Smtp-Source: AGHT+IFXK4cMxkwhYN3vUAMTaEKsnmqS3oLSY0eLfwVLE1AnaOxe3Ag130M3IRbwp0fwz3L/4Dym2Q==
X-Received: by 2002:a05:6a00:1485:b0:736:51a6:78b1 with SMTP id d2e1a72fcca58-739059bfdb8mr16414535b3a.11.1742737162603;
        Sun, 23 Mar 2025 06:39:22 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73905fab592sm5981966b3a.19.2025.03.23.06.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 06:39:22 -0700 (PDT)
Date: Sun, 23 Mar 2025 22:39:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Wouter Bijlsma <wouter@wouterbijlsma.nl>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/bwctrl: Fix NULL pointer deref on bus number
 exhaustion
Message-ID: <20250323133920.GK1902347@rocinante>
References: <3b6c8d973aedc48860640a9d75d20528336f1f3c.1742669372.git.lukas@wunner.de>
 <20250323112456.GA1902347@rocinante>
 <2e16d6af-7d7d-47a7-9c69-26f0765a83d6@app.fastmail.com>
 <20250323125652.GJ1902347@rocinante>
 <eaa54741-e15c-457b-9313-1d5bcb518860@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaa54741-e15c-457b-9313-1d5bcb518860@app.fastmail.com>

Hello,

> > Would you be happy to provide your "Tested-by:" tag?
> 
> You can use 'Tested-by: Wouter Bijlsma <wouter@wouterbijlsma.nl>'

Added to the other tags.  Thank you!

	Krzysztof

