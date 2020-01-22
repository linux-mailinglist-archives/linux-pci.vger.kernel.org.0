Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32401454E6
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2020 14:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgAVNPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 08:15:16 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39206 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgAVNPP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jan 2020 08:15:15 -0500
Received: by mail-lj1-f194.google.com with SMTP id o11so6441595ljc.6
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2020 05:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Faj6KZwbywL/fDhwIy1bk+O7WVLH18b9dyX96AmRRQ0=;
        b=eW0+pZuAbyQpXe0eNgMVb2A2jQbxIGZL1kKC5g/pnIL+TFJWdyCmmYNyPTrKIHp9R8
         DfwCi4Lvhhj6++MVt6DeVFRJT0gY99T8Eqs2cGza3fszagi6DITfJ/WHgOZfEo40ljm6
         N9RZc4QX4qWJgCKH3Dydvn2/zOETsnki/tbawsj/Pl8yoZgUKaa5FZx6OA1QZBwhfGpn
         WGcM6sJcv1X+6pxZn/+/VUNsgcEJ79y2Jx+xc/LfxNSE67XGQOx8fL+CYb/edQHDDL93
         FDn/i661XMnlcT8QUceGHxP9u44XbWVM8FUoK+YXsXTz2o7s1M4uKr5QITpFx2XGQGVJ
         b3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Faj6KZwbywL/fDhwIy1bk+O7WVLH18b9dyX96AmRRQ0=;
        b=mWgNW9fUFwMAsHCQ+vv0cEUIpr2+8fVcwAhV4N2SVibzs/Uqpzwr2uJVRdDSbyG+P4
         LebmeHkk30Cz3zGjmKnCDai5XKf3g6CgsUIb0QTTIwBH5oWnWD4fRblXgSwRirAYA2ud
         kPTdN74xEBT1yUgXylfnYCGj+waQFl1IRUKM4iUkolEf0Mkf8w//SNCPNJaefAm9p9le
         LaVkybdm4wAxjN1/wXxhjxcbiP2UZ8OWlqgnmS0B+qEAykeS/WOB0cbk8uNE1V6WaBga
         4hQ1CDy1pBRL7dTkNO9j6JT5z2dUQkNP1utYrAaWGbPmv6O9aO6TATDG1FohOfLxrta6
         iQ+A==
X-Gm-Message-State: APjAAAVVIZxc6nqv/q2fJNCqOjZpuUyhBB31FDSh1etFbPbDKG0i8/X3
        kOk5vRAr3/yvqQ2eAlVzyhZYWaMK+zQgYg==
X-Google-Smtp-Source: APXvYqzlr7QFPqoj6tJkRUZfY61xSbZS0PzDr03r8IVyNMvQlcrU90gqef1GiyVdKRgNcQLMXilWCg==
X-Received: by 2002:a05:651c:1032:: with SMTP id w18mr18256340ljm.61.1579698913553;
        Wed, 22 Jan 2020 05:15:13 -0800 (PST)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id q13sm19970691ljm.68.2020.01.22.05.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 05:15:12 -0800 (PST)
Date:   Wed, 22 Jan 2020 16:15:10 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Cc:     linux@yadro.com, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH RESEND] ntb_hw_switchtec: Fix ntb_mw_clear_trans
 returning error if size == 0
Message-ID: <20200122131510.d5ckfj22idh56ef5@yadro.com>
References: <20190710084427.7iqrhapxa7jo5v6y@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710084427.7iqrhapxa7jo5v6y@yadro.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Somehow this patch was lost. The problem is still actual.
Please, add to upstream.

On Wed, Jul 10, 2019 at 11:44:27AM +0300, Alexander Fomichev wrote:
> ntb_mw_set_trans should work as ntb_mw_clear_trans when size == 0 and/or
> addr == 0. But error in xlate_pos checking condition prevents this.
> Fix the condition to make ntb_mw_clear_trans working.
> 
> Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index 1e2f627d3bac..19d46af19650 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -299,7 +299,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>  	if (widx >= switchtec_ntb_mw_count(ntb, pidx))
>  		return -EINVAL;
>  
> -	if (xlate_pos < 12)
> +	if (size != 0 && xlate_pos < 12)
>  		return -EINVAL;
>  
>  	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
> -- 
> 2.17.1

-- 
Regards,
  Alexander
