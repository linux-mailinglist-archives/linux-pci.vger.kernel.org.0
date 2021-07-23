Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4763D317A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 04:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhGWBTn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 21:19:43 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:39610 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhGWBTm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jul 2021 21:19:42 -0400
Received: by mail-wm1-f50.google.com with SMTP id o3-20020a05600c5103b029024c0f9e1a5fso2349095wms.4;
        Thu, 22 Jul 2021 19:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wqNvNl7Y9I+Lc0bDPRY2qK0RJphn3sKkuEuDxwoy3ro=;
        b=CrAIV5S8Id5z9sfYuOBpvLXiagAlg41kohLPRcNjWGA7MLVgrBrzQh6/9RrTYHUobb
         gjrcZs1JJCGXO0hPukMDFmjd10v4iEvdNFVzuzPSbywUQx3hn6H8EqHj6kFc28lKIkBh
         p844a5kLg+aOFVbxRvvBABtVZq09U46adHUnRcqn2Hbng5YmsPaHoWCamiB98ABoAQxq
         u7S8cRyF/iXtSc131xTJvE7kvEzHo27wW/O04TVCAWk7/jQ4IdyaKtj1sFAcvA3I6TqZ
         0OomFqdIeJD2tGxYOeiF78adcUYulrz/luOuIBrmZmKKR3OM5MlNPuv8Y81DJwFCMJgp
         VPgQ==
X-Gm-Message-State: AOAM531IFPYhoMZMjEyABndkaBff9g4lC10Wa73NSZOpcEGuKV6OVQ4R
        mRFRifoXrOQnxFeliSAmuR0L2jgsrPxEz97c
X-Google-Smtp-Source: ABdhPJxHcH9H+rY/nRSOPjZVi/EOVXfDrri03O4YuxnL/vddt147+tHPnc93ILllYE3BRn/tcJ/XCA==
X-Received: by 2002:a05:600c:1ca3:: with SMTP id k35mr11536840wms.174.1627005615058;
        Thu, 22 Jul 2021 19:00:15 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l22sm3804431wmp.41.2021.07.22.19.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 19:00:14 -0700 (PDT)
Date:   Fri, 23 Jul 2021 04:00:13 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     "Cai,Huoqing" <caihuoqing@baidu.com>
Cc:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: vmd: Make use of PCI_DEVICE_DATA() helper
 function
Message-ID: <20210723020013.GA2170028@rocinante>
References: <20210722112954.477-1-caihuoqing@baidu.com>
 <20210722112954.477-3-caihuoqing@baidu.com>
 <f2aeb584-6293-78ce-e5aa-4bde34045a86@intel.com>
 <e44664317c2949e794497dc5f903f2a8@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e44664317c2949e794497dc5f903f2a8@baidu.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for sending the patch over!

> 	PATCH[2/2] has some extra indentation, please don't apply it , 

You might know this already, but just in case make sure to run the
"checkpatch.pl" script over the patch before submission.

> I'll send PATCH V2.

You mean v3?  Make sure to include a changelog, if possible.

A small nitpick: the PCI_DEVICE_DATA() is technically a macro rather
than a function, so you could update both the subject line and the
commit message accordingly, if you want.

Also, since you are about to send another version, add period at the end
of the sentence in the commit message.

Aside of the above, it's a nice refactor, thank you!

	Krzysztof
