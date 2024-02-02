Return-Path: <linux-pci+bounces-2982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2408469A6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E507328D4FC
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856F179AD;
	Fri,  2 Feb 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c1zUQMxM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7541802E
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706859220; cv=none; b=mQAtEx6jEfr+7YWum6pBiQqRGMZOiy/EFCEens8CVqNS3m93hHU30qwb48GHMGev2apHG4c4/RRu1lhHgciiWizp9YYXA9niAvZv2Dc03HazIketvAtN8EOLRhMihZqLzv8wsvO9pV0/jlrkeylGzrMdQEhQYCpLpKmY8RRjJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706859220; c=relaxed/simple;
	bh=buSlzPF3S7GF6/asWRPzk7En8b/VyabJNUGslh49XMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VySlgsq+R5vm3GpP3x0dWfgJnNHD/hiCVHou/q0lf+BUmU09u4Jfbda9GmJVazc+wOyVJUEmP3Hf8sdT3iu/sP9QVelRSBewB0es0L0HKynraw2T2uihIgVsC6asKoQToVYFoEsfo7BL4grTeRdiMLPcU22ggtIasnEzeqgA70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c1zUQMxM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso1679210a12.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 23:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706859218; x=1707464018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbAUsmTqXR+rCV57/fxKH34/7KVfGYMZtfpdiEYGAlk=;
        b=c1zUQMxMb4kv5kMHCYKqPLxQqPCiUnJtKdSa7h1X/Ren/1hnkt60sPrGuWy893MKhV
         fMSXaPMfD2OzmPMPBeAM8izbarqISlcxh2oGOMGnLOVWzD9977wEKiW0bToiT3DCBDjs
         VHhfrOf4eEFSAV9oiouZofzwcOPIgWNeQ46fQp5iZEAKtqnUhUTpWuD3CBz767awDqLB
         a4RLO4b3fREnfgY1OrqmKTEYmaHDqvtR5KDDINWzft1Zl9Uvy+EhTAuai2lC/KJZM8Jy
         9ABiCEicvHk+wAv4rAcNOuT8SCILWj0L9wh8mNhcnZPZqyrke6RwnghOELfS0AnptTUj
         FnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706859218; x=1707464018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbAUsmTqXR+rCV57/fxKH34/7KVfGYMZtfpdiEYGAlk=;
        b=HlCFxecAy0//GFIHTp9AVTqK93YUDakWQF/3F6a90R0xKN8hJPCDmjbApNTRiQPXZb
         gxMTHYkGtMwvx12Mrnlc1NaSfEFyJ/MyDOgAVSHZ36ozMQ76bRBWWNzMD4cdlmRJEI5u
         ACqtr3yOl+7Wbiko34zYI04GWHeebuJOEOJLvFBxZduc2HCIpnh3ThNNFnBoXi/LYjZf
         EkRXFIf4G5OTmNLXZOkbHKfCW0VtmyDbs6ykYwD0/5jIY9SZIm5GueNZVKrDlGeUbFQo
         1146LpoL3mMmRM/1LOYqX4cDpfDGKObudw2N2Hgm8lyMvSQ9oSUCNq4lDP0cUs+BgIbR
         u55g==
X-Gm-Message-State: AOJu0Ywobm/gdacuPQt0fBoeYkOQpqhKgB1EQSn18Bm/oVKlEqnoWP51
	h0gTbFBYljKPPS66F+SuOPM7pbyuHxsEmTerD781hpxq8brTsR9H+bZNpDFK5+w=
X-Google-Smtp-Source: AGHT+IHyxVpCIG7ld9OaKKn76hJqzpGW8PV0pmtR2wY0jO9bVq7U7xdwvv/Ae6hMN3OMZ/5W2zb77w==
X-Received: by 2002:a05:6a20:c703:b0:19a:43b9:d460 with SMTP id hi3-20020a056a20c70300b0019a43b9d460mr1053337pzb.62.1706859217888;
        Thu, 01 Feb 2024 23:33:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXLY1tE9uTYjK3K75lkULWBd84lW8OvIo2uKxkmo67jChE2rMbmx3fj6Y75YiV6rADRdLBLszo3ohIzQQipKm3czdSADMDY58sB56vKAlqzIb8CE+Kj4O1TmGSN7Y2ekfHp3C4x/cWHv6Ki7woU+mRC/RlfmM/PxTVzoPCSEEeVGeVk/bWoEwgMA0uwD7x3/PDs/zc98edtlyl36bqfijsJFedM9KX2J+w6L1sT8u0ILRqoGfXofnb9qWds7C2XTQRHc8ShjEz9lb5NBHlGEFL34cwLj6/zjr/oouBuJlonUcYQMv5W+FJfnE2QPpJ9qC6uS8ejTyupXrk+xxp02bqTCdwj9VLcrysLeBzi9ldanuViR7ka8eRbUOODp2OJoQSnhjdLik5tey1z4H9XOShV/pNsdmogYAjS8oUce3RZAFaPU7wnKV0VeJUh/d8fVr0ThMC+yr8LFihjdRIpavdSTEN3KciUL8/EMMZ8Piv7Ch6pYmCXfx7zSrVC88obzZdUpxd+1NMZxlx/pCOmtFVtmdnolvxgK3O/IP2Zws1mGpp+jeTkbNkLJC2xsjvWvwmsMuUfPhbhcrnu61mhH2UDmi36+v7tqVB/Pi5sr7QfWfaT4iZKFFKaJAAE1OYKtzFX/aGyWENmmwtFq3U8oaFwM055xkLKAVsfVAOa6nZ6PW7kFDPIovBxvGN3hlwFVB3D7a2pMqcAVj7nX30IaDYa/YiOGPoWBA==
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id nd14-20020a17090b4cce00b00295fdf538e1sm1115322pjb.12.2024.02.01.23.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:33:36 -0800 (PST)
Date: Fri, 2 Feb 2024 13:03:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm8450: Add opp table support
 to PCIe
Message-ID: <20240202073334.mkabgezwxn3qe7iy@vireshk-i7>
References: <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
 <20240129160420.GA27739@thinkpad>
 <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>
 <20240130071449.GG32821@thinkpad>
 <20240130083619.lqbj47fl7aa5j3k5@vireshk-i7>
 <20240130094804.GD83288@thinkpad>
 <20240130095508.zgufudflizrpxqhy@vireshk-i7>
 <20240130131625.GA2554@thinkpad>
 <20240131052335.6nqpmccgr64voque@vireshk-i7>
 <610d5d7c-ec8d-42f1-81a2-1376b8a1a43f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <610d5d7c-ec8d-42f1-81a2-1376b8a1a43f@linaro.org>

On 01-02-24, 15:45, Konrad Dybcio wrote:
> I'm lukewarm on this.
> 
> A *lot* of hardware has more complex requirements than "x MBps at y MHz",
> especially when performance counters come into the picture for dynamic
> bw management.
> 
> OPP tables can't really handle this properly.

There was a similar concern for voltages earlier on and we added the capability
of adjusting the voltage for OPPs in the OPP core. Maybe something similar can
be done here ?

-- 
viresh

