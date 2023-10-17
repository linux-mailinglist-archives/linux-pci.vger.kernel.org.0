Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135FE7CBE52
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjJQJBt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 05:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjJQJBo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 05:01:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF99123
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 02:01:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32daeed7771so2010590f8f.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2023 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697533300; x=1698138100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0ZwSxcglD63mlTmCZgEp9zNaqcuyVBL+a1pqctvEUg=;
        b=PPexVhVaIAM5qUx+Y8sxnj/6/ZCxwnbOXXNuFODKiYlo8dx4YTF2/9rFjZ0sdja9t+
         973L/2Reyr+iExOy4Eirp3peys9AcbDFwgvj7uTS5rwmAcGx89P6Xxm14fZFvIqiWwoA
         Oc+RFgDmqYGOCqxBhK93ZWmIFZzS7XLgAU5MwCfw3cYWamqWzPjBQwX5missbGm6pP6z
         7wVFe04t+zwlk0NIJrwKA6eY7qOQ3sShJogPKObRppwgLxD48U5m27HWOWFj97fwQ93h
         +EFSF7hRhDhbDv2d1aufbyMosECtFXZnzD0CY4GwZQ3VBlq9o9kHrOabMcJepdacooFf
         D98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533300; x=1698138100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0ZwSxcglD63mlTmCZgEp9zNaqcuyVBL+a1pqctvEUg=;
        b=NwoRjYmhHbkOL9bFRHms1kLpPEBWsUKZNC6TcpubvKyZ1/cUdJksROddgYjT6Q2seK
         fKuIy1Sfhj3GdwbVPI01/4BxUWO4pQ1ikYwEOdIO6q50fMTqyB3fupuphiifxsnVKMNq
         IaPphlXuPT+9eiaAg/jsbN2gJdPOmVwYk10Vy1XcmStvL1Q9lvmGIuRLyYaRjjgVUu2C
         /QcTk83z6A2OoRyvdx7hwSW1jwX4RvOh87el5NRJoDteBRYa5wFHLvP94V1Xibofz5AV
         1fizX012R3AVbLWO4ZJT+8iHllk+iy7B+Njmp0o03RImTHH/Cp7+oHn6Ns+S4OVlSsbd
         jfiw==
X-Gm-Message-State: AOJu0YwVausDCPTnj2Hf9RJBGxuDFBBoZBXDC+dixWp3G7e9+CgayTt2
        pEe81fmuBA727o//DIEHH2Kb4A==
X-Google-Smtp-Source: AGHT+IF5WzTohtQMpALIknd58a9nZY7AlTTTgEMp4caFdIhtlHk0o8BsyBUOrFNhAS5GQVSEORRBtQ==
X-Received: by 2002:a5d:5347:0:b0:32d:b654:894b with SMTP id t7-20020a5d5347000000b0032db654894bmr1227002wrv.32.1697533299879;
        Tue, 17 Oct 2023 02:01:39 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d51c2000000b0032da4f70756sm1208902wrv.5.2023.10.17.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:01:39 -0700 (PDT)
Date:   Tue, 17 Oct 2023 11:01:38 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, bhelgaas@google.com,
        alex.williamson@redhat.com, lukas@wunner.de, petrm@nvidia.com,
        jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 02/12] devlink: Hold a reference on parent
 device
Message-ID: <ZS5Nclma7BXGNX3F@nanopsycho>
References: <20231017074257.3389177-1-idosch@nvidia.com>
 <20231017074257.3389177-3-idosch@nvidia.com>
 <ZS4+InoncFqPVW72@nanopsycho>
 <ZS5BrH1AOVJyt6ac@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5BrH1AOVJyt6ac@shredder>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tue, Oct 17, 2023 at 10:11:24AM CEST, idosch@nvidia.com wrote:
>On Tue, Oct 17, 2023 at 09:56:18AM +0200, Jiri Pirko wrote:
>> Tue, Oct 17, 2023 at 09:42:47AM CEST, idosch@nvidia.com wrote:
>> >Each devlink instance is associated with a parent device and a pointer
>> >to this device is stored in the devlink structure, but devlink does not
>> >hold a reference on this device.
>> >
>> >This is going to be a problem in the next patch where - among other
>> >things - devlink will acquire the device lock during netns dismantle,
>> >before the reload operation. Since netns dismantle is performed
>> >asynchronously and since a reference is not held on the parent device,
>> >it will be possible to hit a use-after-free.
>> >
>> >Prepare for the upcoming change by holding a reference on the parent
>> >device.
>> >
>> 
>> Just a note, I'm currently pushing the same patch as a part
>> of my patchset:
>> https://lore.kernel.org/all/20231013121029.353351-4-jiri@resnulli.us/
>
>Then you probably need patch #1 as well:
>
>https://lore.kernel.org/netdev/20231017074257.3389177-2-idosch@nvidia.com/

Correct.
