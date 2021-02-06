Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4975312080
	for <lists+linux-pci@lfdr.de>; Sun,  7 Feb 2021 00:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBFXcA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Feb 2021 18:32:00 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45467 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhBFXb7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Feb 2021 18:31:59 -0500
Received: by mail-wr1-f43.google.com with SMTP id m13so12567640wro.12;
        Sat, 06 Feb 2021 15:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjYjcEofR6lNR/I0DZSWZ30pohQFASDcROijEHvASfk=;
        b=ZoggzEQ+pvxS7xp7i5Esv0+Sjcv2zX818ixeZeR3RH9XEuuwPOR0jXnru6sHNdWItT
         ml23XMQqDA2wdQ2wBsLnA/NpBdWt6GU9ZMQKpagd5Gozst3hVyiHwPIpQC7ux+mxThlV
         4Ik/55ywnhP/GTYs81gpAOetNyVHNp5FM0IsWkSiO6rKSIDzBh91E5WDV53DKyLf6IZX
         OfRqtSXmVAQ/Pq6T7pui8oddK3tnIaxYezwXx9HoP0v8oMgPjLI42h45Z3CVVsveCwgi
         38DH05w0JwDJ+tcQH80fHLaUJmASfO76sEeh46Y2eEAaRbwt1AiSIuKWxmkH0MtfOXTF
         i+FA==
X-Gm-Message-State: AOAM530YIkeF1G12DsvpT599iLQ4zRmEpFlVQATILRbASVyjiexMPSjY
        c1G6TGjZHaTBeX0UrYBPpBmbmAWfWsuuuTQK
X-Google-Smtp-Source: ABdhPJyviThF+C226ccwvm0Yz791/heX9KN5ZUvUKv70glVs6XpgX6GbMLDuta/nqLy/orcKkMMGnA==
X-Received: by 2002:adf:f6d0:: with SMTP id y16mr3212434wrp.351.1612654277840;
        Sat, 06 Feb 2021 15:31:17 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o124sm13395628wmb.5.2021.02.06.15.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:31:16 -0800 (PST)
Date:   Sun, 7 Feb 2021 00:31:14 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RESEND v4 4/6] Documentation: misc-devices: Add Documentation
 for dw-xdata-pcie driver
Message-ID: <YB8mwrhOZ2kPL3Oo@rocinante>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
 <2cc3a3a324d299a096f1d3e682b2039d3537b013.1612390291.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cc3a3a324d299a096f1d3e682b2039d3537b013.1612390291.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

[...]
> +The interaction with this driver is done through the module parameter and
> +can be changed in runtime. The driver outputs the requested command state
> +information to /var/log/kern.log or dmesg.

The driver does not seem to offer any parameters (aside of using sysfs
for runtime settings), and it also seem to only print what it's doing
when debug level is enabled - unless I am missing something?

[...]
> +Request to stop any current TLP transfer:
> +- Command:
> +	echo 1 > /sys/kernel/dw-xdata-pcie/stop
[...]

When I do the following:

  # echo 1 > /sys/kernel/dw-xdata-pcie/write
  # echo 1 > /sys/kernel/dw-xdata-pcie/stop
  # cat /sys/kernel/dw-xdata-pcie/write

Would output from cat above simply show "0 MB/s" then?  I wonder how
someone using this new driver could tell whether "write" or "read"
traffic generation has been enabled aside of reading the sysfs files,
would adding "/sys/kernel/dw-xdata-pcie/active" be an overkill here?

What do you think?

Krzysztof
