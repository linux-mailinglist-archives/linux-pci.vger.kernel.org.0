Return-Path: <linux-pci+bounces-13990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3A39940C8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 10:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DB3287B84
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1B1DEFDC;
	Tue,  8 Oct 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTiVEAP0"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02233190463
	for <linux-pci@vger.kernel.org>; Tue,  8 Oct 2024 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372751; cv=none; b=YVRJ2ihSkSOc35RlnTzRDuNObyceOV7/YwmbNFGjU20fSZsmIfxgtygsRLTlKjZQl5KP8U8Pq28bJACRNgJCGGov80freytTELj2ofURSn38KIsRA8wMj+LxguHX/pCK3BxvRRNFSXEBxwXoJOS2g82FcAk9p9JAYWDmPsK95BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372751; c=relaxed/simple;
	bh=DwhgU5Yy+8M4tb16A5X8DlJ7lDayv35s+EicK1uxF5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvWhFC1dZtCZEAnNs9qEJIz+VbXIzmx2Dwscs2LK0d+x1HxWtweZaokpa53gIJnelK68xOnt+J6eutDAAIzI9fIKQ8Vl3y1Rdl5e3ZgPupGc/ooAGpLcc/Gb7eLYdia9e2eYCTvMU/mCGoQOvzI4N1vsdGg1JmhQ8Dy8BeFtyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTiVEAP0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728372748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUVvUSYhWlp+88sIj5WPfwtDLumv/s1zi3uObWKuh70=;
	b=LTiVEAP0TbziCQ2e6e+IJYEdg+pL3yXKTU/94WWFHXO08zC1CPXHvcfmGuKhPQbEPZhRB0
	rzZ6jU46ISebqrFLH8pDhAm0r26/xN/me8yCnAidQKAcplGnJNwT/P6WrQgdx2TGEH6HL7
	GzW7OxU+Q7KKUGIyj5cXIw664louiLY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-RgicTUg4PTmCsNpDDW3v1w-1; Tue, 08 Oct 2024 03:32:25 -0400
X-MC-Unique: RgicTUg4PTmCsNpDDW3v1w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37cd08d3678so2374362f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Oct 2024 00:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372744; x=1728977544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUVvUSYhWlp+88sIj5WPfwtDLumv/s1zi3uObWKuh70=;
        b=VOqq4ULzxDoT8x5KD58zrONFKQBZIlytWDGMEGvhcaixgJlTZg4l7piCmOr6NSZu1K
         Q+0Bmp8u7iimdAetQ4BKTWbeUqR/AP6wEkmzV5JVkOulJCkKmKvivfJnqi7Y+ORmCEtE
         po6Jb5IcF6+xgiiBQvSlzZTzpli/+e0xi2rCIE5ptVwCqidd1nHKY1RsFwPpsuOotIP9
         l4MeeY927vevROQaJZwTm7w4ZTpgyZgW+EGRWdRNkFibHUFHRJEBmGS80z3EMpavXlsH
         BptBilZjKoMyQTgiozImmk0lCH5IIV7VFul1yjjsUDzVTV90pImnrwzt1KkIlJvRftBB
         llDg==
X-Forwarded-Encrypted: i=1; AJvYcCUTL8joRLEt5hTDdObiKQx3/jZ8DGx7wDmKDfUF2YFPmzjdhBJz1kSKa2GSMvbBiUIqLDiDxRtCaSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwqGA5BhmyO8edmRVHsxpV5T+LVLz/1EHGMfEngjNytuRofKTE
	3zjiZlqplRxoPJPb70q97KsN0MY+d6/0aAG+RXg2/jkpQs6SzSUFv/0m9wErMC+l2Dz6TRr+MaC
	+SwxrYTDeJDwLajCqywvUdS9XqD5jzK2styAnleC9k46N0paPdJwu5Pz+/g==
X-Received: by 2002:adf:8911:0:b0:37d:34e7:6d22 with SMTP id ffacd0b85a97d-37d34e76e3fmr131240f8f.23.1728372744289;
        Tue, 08 Oct 2024 00:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpCnvtixSaLUfdgYPnnjPQGLPmTjWqJP1lD23M3dwkKjE0komRd6BQG+qeyHuiM222PdHmAw==
X-Received: by 2002:adf:8911:0:b0:37d:34e7:6d22 with SMTP id ffacd0b85a97d-37d34e76e3fmr131205f8f.23.1728372743768;
        Tue, 08 Oct 2024 00:32:23 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1697301fsm7326394f8f.100.2024.10.08.00.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:32:23 -0700 (PDT)
Message-ID: <4bd1d414-3f69-44d5-bb41-c44509b38f89@redhat.com>
Date: Tue, 8 Oct 2024 09:32:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 0/5] TPH and cache direct injection support
To: Michael Chan <michael.chan@broadcom.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, Jonathan.Cameron@huawei.com, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 alex.williamson@redhat.com, gospo@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20241002165954.128085-1-wei.huang2@amd.com>
 <20241002213555.GA279877@bhelgaas>
 <CACKFLi=ieNNx57i1fG2R6+C1LyXV4oY6=e9AD+Pw-8WtW2X8jw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACKFLi=ieNNx57i1fG2R6+C1LyXV4oY6=e9AD+Pw-8WtW2X8jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/24 00:08, Michael Chan wrote:
> On Wed, Oct 2, 2024 at 2:35 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> I tentatively applied this on pci/tph for v6.13.
>>
>> Not sure what you intend for the bnxt changes, since they depend on
>> the PCI core changes.  I'm happy to merge them via PCI, given acks
>> from Michael and an overall network maintainer.
> 
> The bnxt patch can go in through the PCI tree if Jakub agrees.  Thanks.

I guess the most critical point is to avoid complex conflict at merge 
window time. My understanding it that the conventional way to avoid such 
issue would be sharing a stable branch somewhere with this change on top 
which both the netdev and the PCI tree could pull from.

Cheers,

Paolo


