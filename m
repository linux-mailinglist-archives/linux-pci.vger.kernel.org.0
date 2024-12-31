Return-Path: <linux-pci+bounces-19136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4239FF15E
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 19:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0D1161ED5
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 18:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518C189F45;
	Tue, 31 Dec 2024 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KF6hU9H2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AB17BA9
	for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735671251; cv=none; b=BNxWN1IF8DV4mLu4G+nCgHGQi3rxXj1WYaJCLS+SkzNgTMY9Ljjy0rqbKmuar77yYBViYy/NlL/HlInBS4sd6tZBWOtqdxWLlVvcCXQQ7sJ5h2DNxhwfmKzTJIjZRQnuQYd6BIue5uvtDYWmXz2lhQkA0woyUiH2+4Ws+lQI/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735671251; c=relaxed/simple;
	bh=AJEFAVzL/HbqcoiQ8tXYXqgWMHWVQ06bY4THGwNBmyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/fCVEoeDJTrnQLH0QquvDHgcmVZ8EKGBHIMKVyV28v2blxic6JQ2iLTkVx9XmQ55/PffwRW7NBx4u4ySMh/LN7PGaV+OWfvfCziSP0tQMwUmLJBtqwE3WVtCPlHfKbW9+ytH5egfnhrevSzlYfqG1VGO76k9czpAaw+M6y7iPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KF6hU9H2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-218c8aca5f1so168226835ad.0
        for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 10:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735671250; x=1736276050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ua/yw6V8Q4CSnKq963SOOaPsasHaAarnVdaMbju8qdY=;
        b=KF6hU9H2j7UInyfm027e4ksqRwb3iVaihqDixEBrVB0CNsmHi6zJS8mM0bOc3YAOnm
         hOubhihEW2N/2q0ebv5LYf9PvUsjZhWG15QRvjHJ6kZ9j5xwWBL/YXP2HU3IOB+NEpX2
         1Z67ND/kDG96HrqIsKeALn8H7E4LDoon5XjXOUD+KS1PUlANw/SFryrXhiS2vA50/8AJ
         oio1WLoaVMvP3Nj9H7f2xAsI9hjCaf486nxMalzEf0cICNr4SkymcjDyo2f91JzS5HIc
         gQPChRNWpOJ8xSxKxg67Wa1ntS/LbvsFrfku5yXJGrXUYJdmlTecwsS3UKLVj5VRuYic
         q0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735671250; x=1736276050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ua/yw6V8Q4CSnKq963SOOaPsasHaAarnVdaMbju8qdY=;
        b=si2E1SO70o/pRlR/pmM/MG0SskrQxYBB0RTbABLglEIC2p6j8vBSzfa9BWVekiYu/z
         DVrfgFH7+uhEX4UBVEiXtxg/ImD9aLfGkqNv8iKR8CAAp+EGGmRJnIf2GS749IYth/i+
         +L9S8PdeBks1wu1SaDYiTvDlVMSuxf53JZy4xk6MGMXc0r9MVS2xjaap2TZgbT6xi+OF
         K30bBNpg0Ii/TarPxF+Sy7sAOtRlrQvr7zVH/S4AWiIWSVBb8qmDWihRmfjS0hiUTFR9
         m0ZohG8hDD/v5c7/9O0XFD+qixoGUFJ2/eJfiqzN/YT/S0yjlNYVUqvwd/HnKiPZSouF
         DeYw==
X-Forwarded-Encrypted: i=1; AJvYcCXGLqUxWW7uDkD0xvLl7v9Ak/bjUVe9In1KBKJAw88zABwhJ0Lps9Ta3k4seArubWfM8tZvLHYBDQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUJLk8X/eHfOMPahKSEPi4KX8ssxWgOKPbSBtn5p53NDZbGi68
	bi1fv4+vakqIEtThVj0HfHfmqv/L9ax1wn8z2R+R3GNo3knlgOtdR59NrVrNhA==
X-Gm-Gg: ASbGncvpLPkY/+r3nGMU7MRPYMgWeXcM0R9iw6QIPoXa2xGoDlydsQwxX4qpGFfvqph
	pm/xy1vp+BN9vDCFwBOV/QmnXlB/LfEgol2tWzyfsWyC1Q6A3jylogowFX6tmFvp6edBn3WKRFX
	DYP/pDdbn6WPOrI6zJ0y/eavNiALGecUCTwcZn5C/t1KPmHDp4hbIi4msib+DvVGRev8/LdUFGJ
	656z24jrV1Tw/ZhqNlwkko+2pHu9IYk6YIWVpDAMl27tL70asNYE26N7IcjTHVONOX4bw==
X-Google-Smtp-Source: AGHT+IHii1qezFhDHOKljpGsqj4ki15dTKkn+b3lPak25MTzh3DjlarAmgatBnyU5d76VwQJDJheiA==
X-Received: by 2002:a05:6a00:23ca:b0:725:df1a:282 with SMTP id d2e1a72fcca58-72abdd7f65fmr50539277b3a.10.1735671249856;
        Tue, 31 Dec 2024 10:54:09 -0800 (PST)
Received: from thinkpad ([117.193.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8157d7sm21926176b3a.21.2024.12.31.10.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 10:54:09 -0800 (PST)
Date: Wed, 1 Jan 2025 00:23:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/3] selftests: Move PCI Endpoint tests from tools/pci
 to Kselftests
Message-ID: <20241231185359.7dqhzxlmrdkcscug@thinkpad>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
 <20241231131341.39292-3-manivannan.sadhasivam@linaro.org>
 <Z3QnESese3Le9FP0@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3QnESese3Le9FP0@ryzen>

On Tue, Dec 31, 2024 at 06:17:05PM +0100, Niklas Cassel wrote:
> On Tue, Dec 31, 2024 at 06:43:40PM +0530, Manivannan Sadhasivam wrote:
> > This just moves the existing tests under tools/pci to
> > tools/testing/selftests/pci_endpoint and adjusts the paths in Makefile
> > accordingly. Migration to Kselftest framework will be done in subsequent
> > commits.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Why not squash this patch with the subsequent patch that actually
> converts the tests to kselftests?
> 
> If you just apply this patch, then we have moved the code to
> testing/selftests/ but the tests are not actually kselftests,
> which doesn't really make sense IMO.
> 

As I mentioned in the cover letter, this was suggested by both Shuah and Bjorn
to preserve the history:

https://lore.kernel.org/linux-pci/b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org/
https://lore.kernel.org/linux-pci/20230117195903.GA142672@bhelgaas/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

