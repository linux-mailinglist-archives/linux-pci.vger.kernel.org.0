Return-Path: <linux-pci+bounces-1974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BD18293E2
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 07:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9020EB25387
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 06:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71331364CF;
	Wed, 10 Jan 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEdiWc74"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B234CFF
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3e416f303so13794505ad.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Jan 2024 22:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704869880; x=1705474680; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GBt4RNNT5Udrunysdba+pFX1wxxljz+GPhqieimh10g=;
        b=vEdiWc747a15KMtDZcFBtJpMmcSVIRX82MRTCMcXwXemLEIbZ9ufSrF22IH2ui4Ik5
         VGjDFVllwuwvDNmVNE1DvzAQ8Uja52ibli2jZJ2LYBo5/YagJtsEP83JdtrZvJUjjKMA
         E+9346PI5C9bMWbohUBfJLmyoaw8sc89HyumwLh7A5Ta6j+aJnNzM2PRDCbMl7iNvQWL
         jVKI2gyWTZ3O4hB5miqk+lUyPa/knVLFxYZQxppNlt+47a1JtwN5LHOudNnivJjJCPgW
         7ZtPXwL2O8dgS2HuF1a6CfCs1jenTeR8nrgWhhi99sk4N5v6oTKb+cS7K65TGWHxVBpf
         g6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869880; x=1705474680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBt4RNNT5Udrunysdba+pFX1wxxljz+GPhqieimh10g=;
        b=P+Kese8Bf27MO80epZ9mo8hRtgYFjnIJxr6OTcxbmqoqwMctwhXfp0iIvxB6h9ffdF
         gaM0pKKev99e7HXgWglquyPVRl07UmqsnVvugwqJ1bfvAQAVGxOiTGkdfAFUA8JveAsq
         p93f1Y0rnUlxoj9LYbILNZ27NCjn3wFdYtyqz2olvorw4iGO4dxSgQjw/Se1ahwosEEF
         1l0rsiWtpK7YeTl2nKav4CoTWFJ0RI3i1hVGRACeoLRDBn7COhXYOQuUokUwwRwnQL28
         NowxXaA68v5KYhQmRIFufivvJ95zLPuKWFncwLHwmbqTj6y1MybgyJ/6EYROUTm3Cbf0
         WHsw==
X-Gm-Message-State: AOJu0YzAtWs2t8aw1hq6Z6T/nMXRejNvTdaDm4WU6qIHT+iQUqbN3CW4
	rRSkl6lxckdvoHUXn9D/YbfvIP4R4IY4jg==
X-Google-Smtp-Source: AGHT+IE+fzYVlUMTlLXHdh6PBiZwhLw2zWvoqNw2CQsktuCCXv/r/7cTCDcu6yf84bzkmhKGBHha0g==
X-Received: by 2002:a17:902:ecc2:b0:1d4:28f:29e5 with SMTP id a2-20020a170902ecc200b001d4028f29e5mr515216plh.24.1704869880397;
        Tue, 09 Jan 2024 22:58:00 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902b08300b001cfa0c04553sm2882969plr.116.2024.01.09.22.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:57:59 -0800 (PST)
Date: Wed, 10 Jan 2024 12:27:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, rafael@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_ramkri@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v5 5/5] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20240110065757.xde2nvpr3z7c4isu@vireshk-i7>
References: <20231102053013.7yt7pxin5awlu7w7@vireshk-i7>
 <20231102120950.GA115288@bhelgaas>
 <20231103051247.u4cnckzstcvs4lf5@vireshk-i7>
 <15a98ec0-214b-218b-1e3c-c09f770fce2e@quicinc.com>
 <0ba9f2af-169e-a9a2-9ae4-4c6a70b0a94e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ba9f2af-169e-a9a2-9ae4-4c6a70b0a94e@quicinc.com>

On 08-01-24, 18:49, Krishna Chaitanya Chundru wrote:
> We calculate ICC BW voting based up on PCIe speed and PCIe width.
> 
> Right now we are adding the opp table based up on PCIe speed.
> 
> Each PCIe controller can support multiple lane configurations like x1, x2,
> x4, x8, x16 based up on controller capability.
> 
> So for each GEN speed we need  up to 5 entries in OPP table. This will make
> OPP table very long.
> 
> It is best to calculate the ICC BW voting in the driver itself and apply
> them through ICC driver.

I see. Are the lane configurations fixed for a platform ? I mean, do you change
those configurations at runtime or is that something that never changes, but the
driver can end up getting used on a hardware that supports any one of them ?

If they are fixed (second case), then you can use dev_pm_opp_set_prop_name() to
make that easier for you. With that you will only need 5 OPP entries, but each
of them will have five values of bw:

bw-x1, bw-x2, ....  and you can select one of them during initialization.

-- 
viresh

