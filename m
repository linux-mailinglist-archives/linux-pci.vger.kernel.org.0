Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8366C33037B
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhCGR6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 12:58:33 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:44555 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhCGR6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 12:58:33 -0500
Received: by mail-lf1-f47.google.com with SMTP id p21so15744063lfu.11;
        Sun, 07 Mar 2021 09:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=53Y7sAoUxyd20JgTNU1QO+5AAS7j3JGSd+vyoZjtk1M=;
        b=AqIuELJAUDBa4JF4B5HtNcVK5VxHH6gdKDHLTbf2/fUuu4oLGWykYc44VyJ+lodRdx
         LUNW0jo8e1eTh9MDn2jMOL+iMhOgAwyFOikYxxNxaR7sunWA+N5/XkozlLUVPU7eMII+
         7P9Mr4CIQbqlJpetkFaBNEgzIXBgM3e/OJcalD9W9VR7uYdZC7qjjp5GVe7AIj74N1aN
         dAS828jRJfQrSMjzHBVBL5A7hLSnjXTlCzPL2DbK0gX6kcW71btFkX9ugBtTSftzxyv4
         /K1Hyq8+u1UJZzNxtCBhYUWyh1iysdVCmeVv4kokbKtsDKzCiVW7wrAHrCq/bFYZFJ5m
         FlnQ==
X-Gm-Message-State: AOAM530wfiwVJbmoicDoKS/g8VBy1bknfCGz1A11XV/PrH2uLVlX3CSH
        mYA7K1pMbHw42Sugn2HNjTQ=
X-Google-Smtp-Source: ABdhPJy+n/WepNUcFPsKh3hShWPKwBh4bHVWyA/uvDMzNUm20xRhsuF/zmXZLoioa9zmw6e413QPSg==
X-Received: by 2002:ac2:58cf:: with SMTP id u15mr11828308lfo.397.1615139911580;
        Sun, 07 Mar 2021 09:58:31 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p8sm1073785lft.193.2021.03.07.09.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 09:58:30 -0800 (PST)
Date:   Sun, 7 Mar 2021 18:58:29 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        helgaas@kernel.org, moritzf@google.com,
        Brian Foley <bpfoley@google.com>
Subject: Re: [PATCH] PCI/IOV: Clarify error message for unbound devices
Message-ID: <YEUURfQjcUq053y7@rocinante>
References: <20210108220630.10863-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210108220630.10863-1-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Moritz,

[...]
> +	/* is PF driver loaded */
> +	if (!pdev->driver) {
> +		pci_info(pdev, "No driver bound to device. Cannot configure SRIOV\n");
> +		ret = -ENOENT;
> +		goto exit;
> +	}
[...]

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
