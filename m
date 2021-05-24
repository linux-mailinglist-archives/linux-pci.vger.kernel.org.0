Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928B038E409
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhEXKb7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 06:31:59 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:38775 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhEXKb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 06:31:58 -0400
Received: by mail-lf1-f41.google.com with SMTP id r5so39939436lfr.5;
        Mon, 24 May 2021 03:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dJqbGZncdUtMbiGujp4GmS4YaN0i9wYrT+dXaGWSBI4=;
        b=mFwuvCFPlkovGwCHWeNueiAh3tdL8BI1O01xRhMc1llw2BKBntohLnUlQPpwqivXX7
         tqXCk/s3XsaGDb8zzogGM7FxlIKJ/YzXYIhTJ5iKjb3hmaKDvs8St3wXfPOxYFV8c7kh
         475u6X/toTIRfcr8uGudc4zY3e09+8JxG+NuHOTxP2vAFwXk0nTpR1JKFZ8gQPOkRLt+
         SDNBFogNURDFybz0SRo3CmTOn6qLLqexMxdpLqJ8qavIT9fOF2hCIvgBhbSGpP6MGMUV
         tnUcpc3S2Q+rg8YlTTMzapqC3H6lOrrcef5V3yPqUK1ydLPYlBOh/9EYpUbgmvSQ/vfA
         5ZyQ==
X-Gm-Message-State: AOAM532qrpYU/ZjTVZFeDpufXCHk/i6g27MV+aRcWhcIHn8EB21cBmvO
        CZx+VvkosfDFqS3NPotQPtI=
X-Google-Smtp-Source: ABdhPJzVY5SY+gr7Xng2BHQIAdlNrQ0z5glCZPpbg8Me/fA0DjkletG1BetDhQ/u9B452+4BX5KSNg==
X-Received: by 2002:a05:6512:10d4:: with SMTP id k20mr9883515lfg.210.1621852228419;
        Mon, 24 May 2021 03:30:28 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x11sm1110485ljc.87.2021.05.24.03.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 03:30:27 -0700 (PDT)
Date:   Mon, 24 May 2021 12:30:27 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     srikanth.thokala@intel.com
Cc:     robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v9 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20210524103027.GA244904@rocinante.localdomain>
References: <20210518150050.7427-1-srikanth.thokala@intel.com>
 <20210518150050.7427-3-srikanth.thokala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210518150050.7427-3-srikanth.thokala@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Srikanth,

Everything looks very good!

[...]
> +	ret = devm_add_action_or_reset(dev,
> +				       (void(*)(void *))clk_disable_unprepare,
> +				       clk);
[...]

Just a small note (no need to change anything) about the above.  Some
drivers add a small wrapper function around the clk_disable_unprepare()
to avoid having to do this case above which is also easier to read as
a result.  But, this is just a matter of whether it's needed (e.g., some
extra steps would be needed to disable clocks, etc.) and personal
preference.

Thank you for working on this!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
