Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B1396127
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhEaOgU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 10:36:20 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:45976 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbhEaOeM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 10:34:12 -0400
Received: by mail-ej1-f42.google.com with SMTP id k7so7437218ejv.12;
        Mon, 31 May 2021 07:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=coTzhk6fH6zG+AoLupwrRfb8b1cQdtJClT31zpmhiG4=;
        b=ikOm6RDFSyRjcOmQhsMsNs9luHpxYfm5vuMviw+qmPyRjN7+dPu1mK6alUh/op246h
         0AsKk3n/vrcdL+6ZDaicU8j28MJpfvCPK8RWhvAHhwYIEly1G6qtRMRGGSoMh6Hnctxp
         jysKyyH1I7oRzJHRPVTu8/PqloUSuTGuRffD13UN5i8qJn6Wb8ZoArfykcJCVfk+PQe1
         ASLA1P+/Y/i1HXv5OkulnK95ofcf3bwczh3SWQqFTOPO25gfhMdt4bTfb/qH0LM6J5TE
         KuidN3TMrfy1ihi9BPyoi+kmjgs8bsJ/475o9KBEg6Bq4SmcqnjpVvw+Aw33+17mjA75
         JnBw==
X-Gm-Message-State: AOAM5300KUBFbkeO5Sozxi0N6GAho/tLt9RJac2UUaZXnDrfdHEGjHnH
        RxbNgXVnQAKKAlR0g5YUse0=
X-Google-Smtp-Source: ABdhPJwpumZCQH+aZf69Hk3S2EUGNIXepfRBGONlrmp7NxTkp0nhmjIcK3SU66wAj+ANIJtyBPC7Nw==
X-Received: by 2002:a17:906:606:: with SMTP id s6mr22851494ejb.206.1622471551033;
        Mon, 31 May 2021 07:32:31 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a22sm276031ejv.67.2021.05.31.07.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 07:32:30 -0700 (PDT)
Date:   Mon, 31 May 2021 16:32:29 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Wesley Sheng <wesley.sheng@amd.com>
Cc:     linasvepstas@gmail.com, ruscur@russell.cc, oohall@gmail.com,
        bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wesleyshenggit@sina.com
Subject: Re: [PATCH] Documentation PCI: Fix typo in pci-error-recovery.rst
Message-ID: <20210531143229.GA157228@rocinante.localdomain>
References: <20210531081215.43507-1-wesley.sheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210531081215.43507-1-wesley.sheng@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Wesley,

> Replace "It" with "If", since it is a conditional statement.
> 
[...]

Nice catch!

> -cycle) and then call slot_reset() again.  It the device still can't
> +cycle) and then call slot_reset() again.  If the device still can't
[...]

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
