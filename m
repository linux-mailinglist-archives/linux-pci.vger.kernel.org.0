Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF98397256
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 13:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhFALaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 07:30:06 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:38678 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFALaG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jun 2021 07:30:06 -0400
Received: by mail-wr1-f46.google.com with SMTP id j14so13897055wrq.5;
        Tue, 01 Jun 2021 04:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HAFqZJJNfiC2AGdxA4gbkC1Qg+KvNCEqsSjmBVkFjH0=;
        b=HfuO5MCXgvAbV7MOMZkdWMS1Szy8LhbEfuEh1DvRd/WJXNx07sNayx9K0vU4MJ1ucX
         GogIsPU0DILCwWAFJD3Mh7Wy9CIgaxm4ozUMk+Yy4HSIgzynnEwQ1H27VhLeOvZrGHXX
         vTKXIHB8Qj4lI5ILNesXbSHT3QfVMa6RWy/G1VjxX0Ee7LaZUa/KXBXIiu9NQUMZ5NIF
         7N2nrMVZ9RdOac2PU0sNFMfpjk32+q4GTLJYQVH94wjEOXFJ8zMomMLPn99mi0Aodq7O
         vuL3xZ5LdPLQrclxohakP7ibUtc0AQiVHYmg3oxmiJM6ufuwYAb/P2RiKsJtUupqtbK9
         0VYg==
X-Gm-Message-State: AOAM531TDIMCugzZ8U3fR+l9eztGbSyN5mX7W/k70jhZtasIwrWsJchq
        UJ2QFVmlWgWrGLXVzPMfwbE=
X-Google-Smtp-Source: ABdhPJzSJFaWOyQO59mkgqVzre/9t0p9NiapOKwk/5uV6uk+H29hMEjZJWzfGWuZPiUwRs81xnoi4Q==
X-Received: by 2002:a5d:6382:: with SMTP id p2mr10176931wru.338.1622546903114;
        Tue, 01 Jun 2021 04:28:23 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o3sm2917179wrm.78.2021.06.01.04.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 04:28:22 -0700 (PDT)
Date:   Tue, 1 Jun 2021 13:28:20 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Disallow retraining link for Atheros chips on
 non-Gen1 PCIe bridges
Message-ID: <20210601112820.GA189305@rocinante.localdomain>
References: <20210326124326.21163-1-pali@kernel.org>
 <20210505163357.16012-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505163357.16012-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

Thank you for working on this and fixing the problem, and also thank you
goes to Marek and Toke for testing!  Much appreciated!

[...]
> - AR9287 chip throws also Link Down and Link Up events, also has
>   accessible config space containing correct values. But ath9k driver
>   fails to initialize card from this state as it is unable to access HW
>   registers. This also indicates that the chip iself is not able to read

A typo here - it would be "itself" in the above.  But this is not worth
sending v4, and I am sure that Bjorn or Lorenzo could fix this in-place
when merging.

[...]
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Tested-by: Marek Behún <kabel@kernel.org>
[...]

Thank you everyone!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
