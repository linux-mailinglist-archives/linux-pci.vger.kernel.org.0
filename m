Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 933D1DAA56
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 12:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405541AbfJQKt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 06:49:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42580 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405514AbfJQKt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 06:49:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so1776606wrw.9;
        Thu, 17 Oct 2019 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fIm13RJUdsjeiq3hJO+LRS6P63Y3wZKzfqSnK5T6+m4=;
        b=gvaLQc3sMRVsTJLruxL3YmkrGyGTSNyIe7SJCD+1DyFqzwpUx0bA7TT09OSdboUWyd
         KtgxwRXGt9nepTHYpXuwxdn2h1ABxRMNVjY/Ur1Wt9I+yT5BevFsGq+73B7Nx/bM8Yl6
         1Zi+R+vQz+onZn+8thqOZ9xpXilz3PFxHVZQoUHamONobmvaXCX/6db80/OO/57febXk
         gxaLK7jfziYlU3eRPVCWoW172Ghx1w3yWXJcj+hSo57HNTC/0dwzgS2jh1l0+T2ngL51
         6Gipw3nstrCyxGgycd9clejHkg3qB3+29DWYfgTjkbT5EE+2jMh6ffz4L9l8JvyTidXV
         n02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fIm13RJUdsjeiq3hJO+LRS6P63Y3wZKzfqSnK5T6+m4=;
        b=gDyOl8ZNSJXhrOXEgEU41TV31VeXWGwv83Kf92SMmCdIdDx0o9vczXB183lxETxvoi
         ZV4mpnH7ilk4hXe+h1cUMl4zmPEs66mAAl5X7ENwkc51uJBW3fX2Fn6vZuTLdUQg1PX4
         upIqCEwHr03w7hcOa4iVKMA261+N4IYntU6ZpW95CmOXggRSELcvap/29EtoXz9GQaZQ
         D+xzItEcemvjDNsEf5fxyKl8XhYccOJ86lGG3sAmXl4rlj7DO6/kGhw6Pi+Udx860u18
         NzIR80a22mt6HWlfE16UIUkw3iFVaXPbnbkNLNgZbhgSWcrtSPYZ/PxDMVuBZj2EDbBf
         +m6Q==
X-Gm-Message-State: APjAAAUIfhuzTpXjcU3fVy2sz8EWDjciKlpCC8mG/mkExHig217Abfa1
        TNAePkpMTk49sK7UuYTed5ApPRFR
X-Google-Smtp-Source: APXvYqxCkpMJCRc1f2g8hfyk+ysEKyE/K4jlFPKvoj+15CpVg7QLoBg00GJftvwSexPnqCdDF+i2dQ==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr2438760wrj.284.1571309395771;
        Thu, 17 Oct 2019 03:49:55 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id r20sm2405202wrg.61.2019.10.17.03.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 03:49:54 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add Marek and Shimoda-san as R-Car PCIE
 co-maintainers
To:     Simon Horman <horms@verge.net.au>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191016120249.16776-1-horms@verge.net.au>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <9cdcef5a-8717-3d76-30e7-f781253e2201@gmail.com>
Date:   Thu, 17 Oct 2019 12:49:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016120249.16776-1-horms@verge.net.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/16/19 2:02 PM, Simon Horman wrote:
> At the end of the v5.3 upstream development cycle I stepped down
> from my role at Renesas.
> 
> Pass maintainership of the R-Car PCIE to Marek and Shimoda-san.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>

Co-maintainer model is great:
Acked-by: Marek Vasut <marek.vasut+renesas@gmail.com>

-- 
Best regards,
Marek Vasut
