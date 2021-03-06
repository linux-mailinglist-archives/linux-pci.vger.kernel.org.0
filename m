Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADFA32FE0D
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 00:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhCFXtA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Mar 2021 18:49:00 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46808 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhCFXsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Mar 2021 18:48:13 -0500
Received: by mail-wr1-f45.google.com with SMTP id a18so7121174wrc.13;
        Sat, 06 Mar 2021 15:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GsSg9NZHndFeKGqbJltei58g+IupXXFzfiPKepnrCQw=;
        b=IjvZ71LdH5kdX21AMvs4Lj1IioKPRzhpKHFlWLVAjTQjRfzCv8xZ6dP9LxpqtbPkII
         5T4sL4YjPFPwJ69CiICo91rYhHLoLIOIQ55VnP7pK4w6SZG8R16soo8/pUFcGW+4lvLt
         m1G5iu3lPz86UBd4bYG/1tdfZwV2X0OWFWr7YK5DTkcL+R0JCHl7DC1NW4UPrihSvsU0
         dtCc2RxW+AksMFktDrlY5j6ybub+iveQbqirTuKcliGWDOtae0MDo8ftHT9VlwNwkbyd
         NBkt8ZbwdxLLf3ztmsCqBf39byNhsz5l7rSfwyNcePYYi9Z00Gtq6K9xGO91TdxJZytz
         h2ug==
X-Gm-Message-State: AOAM532ymfUmcAR9j4BFZJf3HHRsNxTPON5rJNlrqN4JEaupkRz9HtQX
        G5tLjigERqQInMar36KjbgtrKy10ZrG0Yw==
X-Google-Smtp-Source: ABdhPJyHVhXecnVtdtDE6XZwvzt9FTmV3ctCgxj/gGRBgXQ5ozkDl/adjrwLrFi5O1BbGcUIPV1Yag==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr16079877wrt.192.1615074474939;
        Sat, 06 Mar 2021 15:47:54 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j20sm10568934wmp.30.2021.03.06.15.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 15:47:54 -0800 (PST)
Date:   Sun, 7 Mar 2021 00:47:52 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 03/44] PCI: remove synclink entries from pci_ids
Message-ID: <YEQUqP6bxfAKXzcq@rocinante>
References: <20210302062214.29627-1-jslaby@suse.cz>
 <20210302062214.29627-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302062214.29627-3-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jiri,

> The drivers were removed in a1f714b44e34 (tty: Remove redundant synclink
> driver) and 3d608a591b2b (tty: Remove redundant synclinkmp driver).
> 
> So remove also the PCI ID entries.
[...]

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
