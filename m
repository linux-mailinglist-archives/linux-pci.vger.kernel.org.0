Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5511433053D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 00:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhCGX42 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 18:56:28 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:39042 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhCGX4E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 18:56:04 -0500
Received: by mail-oi1-f179.google.com with SMTP id z126so9195353oiz.6
        for <linux-pci@vger.kernel.org>; Sun, 07 Mar 2021 15:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rfOpLmeZMgXquU4qHdZu7D7U6hMqLufsS/co0xXjX/E=;
        b=LvAzto+1A7SX+KnMzivrof2bbsVX0/UZcKAqZ5nkGSXPpA+v+PDegQimDf/9iGub1T
         ae73S3FhCfWR2sAGRD2hLmPSiL3karMlyswyGNxItvtigYJnUsbsKT8p4pclvkLmfzyc
         d7gzuVSQCBuzJymRqLuFyMmV4ol/YAbBI9wMq8Wv+RVb5BNVHTbdl/iiqn1TNughcfQ+
         tIiUZzm47pvZiHYIdMbN186Od2ExyGlMcJXvWrmvjViqcaZon7bqS+Dq0nAMIwV9WMCW
         h2hWgVw5IO4i5su1ckAbtjHR1zrdSQoclJ2s07+VurJ0Av95rNFXbyWK8Tba97KUj1oY
         OD+A==
X-Gm-Message-State: AOAM531m+woGBHlEh+3PmqoyS1FZuPbwtBOdNuZdr91Y29ucQS3SPHjO
        x7s1HkISKB3owJpr13x7eAy6m9u15aZVDA==
X-Google-Smtp-Source: ABdhPJyGBs/ZfGgyJhymPbX4qVynn72Z//B4wec6VaQE7Bq/ViXQvyXpQw2tz2OP97OOQhGvuqKDPA==
X-Received: by 2002:aca:4881:: with SMTP id v123mr2532687oia.36.1615161364128;
        Sun, 07 Mar 2021 15:56:04 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g3sm1984685ooi.28.2021.03.07.15.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 15:56:03 -0800 (PST)
Date:   Mon, 8 Mar 2021 00:56:00 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org, linuxarm@huawei.dom,
        prime.zeng@huawei.com
Subject: Re: [RESEND PATCH] PCI: Factor functions of PCI function reset
Message-ID: <YEVoEKxb+Sj2pYHs@rocinante>
References: <1605090123-14243-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1605090123-14243-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> + * Returns 0 if the device function can be reset or was successfully reset.
> + * negative if the device doesn't support resetting a single function.
[...]

A small nitpick, so feel free to ignore it, of course.  A little change
to the above sentence:

  Returns 0 if the device function can be reset or was successfully
  reset, otherwise negative if the device doesn't support resetting
  a single function.

What do you think?

Krzysztof
