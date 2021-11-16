Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684EB45370A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 17:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhKPQPN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 11:15:13 -0500
Received: from tomli.me ([31.220.7.45]:18203 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhKPQPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 11:15:12 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 342b78f7;
        Tue, 16 Nov 2021 16:12:11 +0000 (UTC)
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO work) (221.219.136.22)
 by tomli.me (qpsmtpd/0.96) with ESMTPSA (AEAD-AES256-GCM-SHA384 encrypted); Tue, 16 Nov 2021 16:12:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=1490979754; bh=ZdeCFomZuUX67sEeX/j/Qslv3H8jxKXMskQ8KBYoi9M=; b=MBKqDqSKYrixUXwILf3eof8388vuaFzxZBV4tnXueE3addZdcfFt9ctOweSrenj6HzV+YsYrIV1rlHELQZmvmBD6D4ezZciZwC1d0CS3McsI7Y/wfyAPElcATrVIFE9g9Ii/27V9E3ow3Mh0H9Qh3GdKBD2asjb/aD7vTDfZUH4xByf5gD6hhZzHH0lbYr9koqgYZH0ZXe2IkAanTWtvlxlG3+2XYI2juPAKj4aCtJCuB8grV2tmtwz9197rOnb/AG1SoGlJwj6OSoHrtu6btLBWMtAO0RZXZyhm871XF3UpVmQ50KcM9BmJjsIr7+1bZt9OntQUIKSo8/wt+5W7MA==
Date:   Tue, 16 Nov 2021 16:12:04 +0000
From:   Tom Li <tomli@tomli.me>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add func1 DMA quirk for Marvell 88SE9125 SATA
 controller
Message-ID: <YZPYVK9UbNXLcks2@work>
References: <YZPA+gSsGWI6+xBP@work>
 <YZPTIllU1KKPviHU@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZPTIllU1KKPviHU@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 16, 2021 at 04:49:54PM +0100, Krzysztof Wilczyński wrote:
> > Reported-by: sbingner <sam@bingner.com>
> > Tested-by: sbingner <sam@bingner.com>
> 
> Both of these tags would require a proper full name, if possible, rather
> than a name that is abbreviated and/or a username.
> 
> Reviewed-by: Krzysztof Wilczyński <kw@liunx.com>
> 
> 	Krzysztof

No problem, I'll send a revision to correct the tags immediately.

Cheers,
Yifeng Li
